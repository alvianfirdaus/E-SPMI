<?php

namespace App\Exports;

use App\Models\IsiStandar;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\WithMapping;
use Maatwebsite\Excel\Concerns\ShouldAutoSize;
use Maatwebsite\Excel\Concerns\WithStyles;
use PhpOffice\PhpSpreadsheet\RichText\RichText;
use PhpOffice\PhpSpreadsheet\RichText\Run;
use PhpOffice\PhpSpreadsheet\Worksheet\Worksheet;

class IsiStandarExport implements FromCollection, WithHeadings, WithMapping, ShouldAutoSize, WithStyles
{
    public function __construct(public $records) {}

    public function collection()
    {
        return $this->records;
    }

    public function headings(): array
    {
        return [
            'Nama Isi',
            'Deskripsi',
        ];
    }

    public function map($isi): array
    {
        return [
            $isi->nama_isi,
            $this->convertHtmlToRichText($isi->deskripsi),
        ];
    }

    protected function convertHtmlToRichText($html): RichText
    {
        libxml_use_internal_errors(true);
    $dom = new \DOMDocument();
    $dom->loadHTML(mb_convert_encoding($html, 'HTML-ENTITIES', 'UTF-8'));
    $body = $dom->getElementsByTagName('body')->item(0);

    $richText = new RichText();
    $first = true;

    foreach ($body->childNodes as $node) {
        $isEmpty = $node->nodeName === 'p' && trim(str_replace("\xc2\xa0", '', $node->textContent)) === '';
    
        if ($isEmpty) {
            if (!$first) {
                $richText->createText("\n"); // exactly one line break for empty <p>
            }
        } else {
            if (!$first) {
                $richText->createText("\n"); // line break between meaningful blocks
            }
            $this->appendNodeToRichText($richText, $node);
        }
    
        $first = false;
    }
    


        return $richText;
    }

    protected function appendNodeToRichText(RichText $richText, $node)
{
    if ($node->nodeType === XML_TEXT_NODE) {
        $text = str_replace(["\u{00A0}", "\xc2\xa0"], ' ', $node->nodeValue);
        $richText->createText($text);
        return;
    }

    if ($node->nodeName === 'br') {
        $richText->createText("\n");
        return;
    }

    // Formatting tags
    if (in_array($node->nodeName, ['strong', 'b', 'em', 'i', 'u', 's'])) {
        $run = new Run();
        $font = $run->getFont();

        if (in_array($node->nodeName, ['strong', 'b'])) {
            $font->setBold(true);
        }

        if (in_array($node->nodeName, ['em', 'i'])) {
            $font->setItalic(true);
        }

        if ($node->nodeName === 'u') {
            $font->setUnderline(true);
        }

        if ($node->nodeName === 's') {
            $font->setStrikethrough(true);
        }

        $run->setText($node->textContent);
        $richText->addText($run);
        return;
    }

    // Ordered list
    if ($node->nodeName === 'ol') {
        $count = 1;
        foreach ($node->childNodes as $li) {
            if ($li->nodeName === 'li') {
                $richText->createText("{$count}. ");
                foreach ($li->childNodes as $child) {
                    $this->appendNodeToRichText($richText, $child);
                }
                $richText->createText("\n");
                $count++;
            }
        }
        return;
    }

    // Unordered list
    if ($node->nodeName === 'ul') {
        foreach ($node->childNodes as $li) {
            if ($li->nodeName === 'li') {
                $richText->createText("• ");
                foreach ($li->childNodes as $child) {
                    $this->appendNodeToRichText($richText, $child);
                }
                $richText->createText("\n");
            }
        }
        return;
    }

    // Regular paragraph
    if ($node->nodeName === 'p') {
        foreach ($node->childNodes as $child) {
            $this->appendNodeToRichText($richText, $child);
        }
        return;
    }

    // Fallback: process children
    if ($node->hasChildNodes()) {
        foreach ($node->childNodes as $child) {
            $this->appendNodeToRichText($richText, $child);
        }
    }
}


    public function styles(Worksheet $sheet)
    {
        $sheet->getStyle('B')->getAlignment()->setWrapText(true);

        return [
            1 => ['font' => ['bold' => true]], // Header row bold
        ];
    }
}
