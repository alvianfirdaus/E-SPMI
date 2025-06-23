<?php

namespace App\Exports;

use Illuminate\Support\Carbon;
use App\Models\AssignPengisian;
use Maatwebsite\Excel\Events\AfterSheet;
use PhpOffice\PhpSpreadsheet\Style\Fill;
use Maatwebsite\Excel\Concerns\FromArray;
use Maatwebsite\Excel\Concerns\WithTitle;
use PhpOffice\PhpSpreadsheet\Chart\Chart;
use PhpOffice\PhpSpreadsheet\Chart\Title;
use Maatwebsite\Excel\Concerns\WithEvents;
use Maatwebsite\Excel\Concerns\WithStyles;
use PhpOffice\PhpSpreadsheet\Chart\Legend;
use PhpOffice\PhpSpreadsheet\Style\Border;
use Maatwebsite\Excel\Concerns\WithHeadings;
use PhpOffice\PhpSpreadsheet\Chart\PlotArea;
use PhpOffice\PhpSpreadsheet\Style\Alignment;
use PhpOffice\PhpSpreadsheet\Chart\DataSeries;
use Maatwebsite\Excel\Concerns\WithColumnWidths;
use PhpOffice\PhpSpreadsheet\Worksheet\Worksheet;
use Maatwebsite\Excel\Concerns\WithMultipleSheets;
use PhpOffice\PhpSpreadsheet\Chart\DataSeriesValues;
use Maatwebsite\Excel\Concerns\WithCustomStartCell;

class AuditResultExport implements WithMultipleSheets
{
    protected $assignPengisian;

    public function __construct(AssignPengisian $assignPengisian)
    {
        $this->assignPengisian = $assignPengisian->load([
            'unitIndikator.unit',
            'unitIndikator.unitIndikatorStandars.standar',
            'unitIndikator.unitIndikatorStandars.unitIndikatorIndikators.indikator.subStandar',
            'unitIndikator.unitIndikatorStandars.unitIndikatorIndikators.unitIndikatorIsiIndikators.isiIndikator',
            'periode',
            'unitIndikator.auditeeUser',
            'assignAuditors.auditor1Relation',
            'assignAuditors.auditor2Relation',
            'pengisianIndikators.reviewAuditor1',
            'pengisianIndikators.reviewAuditor2',
            'pengisianIndikators.unitIndikatorIsiIndikator.isiIndikator'
        ]);
    }

    public function sheets(): array
    {
        return [
            'Detail Audit' => new DetailAuditSheet($this->assignPengisian),
            'Analisis Ketercapaian' => new AnalisisKetercapaianSheet($this->assignPengisian),
        ];
    }
}

class DetailAuditSheet implements FromArray, WithHeadings, WithStyles, WithColumnWidths, WithEvents, WithTitle, WithCustomStartCell
{
    protected $assignPengisian;

    public function __construct(AssignPengisian $assignPengisian)
    {
        $this->assignPengisian = $assignPengisian;
    }

    public function title(): string
    {
        return 'Detail Audit';
    }

    public function startCell(): string
    {
        return 'A8'; // Data starts from row 8
    }

    public function headings(): array
    {
        return [
            'NAMA STANDAR',
            'INDIKATOR',
            'KOLOM PENGISIAN KONDISI AUDITI',
            '',
            '',
            'Di-isi Oleh AUDITOR',
            '',
            '',
        ];
    }

    public function array(): array
    {
        $data = [];
        $pengisianData = $this->assignPengisian->pengisianIndikators->keyBy('ui_isi_indikator_id');

        foreach ($this->assignPengisian->unitIndikator->unitIndikatorStandars as $unitStandar) {
            $standar = $unitStandar->standar;

            foreach ($unitStandar->unitIndikatorIndikators as $unitIndikator) {
                $indikator = $unitIndikator->indikator;

                foreach ($unitIndikator->unitIndikatorIsiIndikators as $unitIsiIndikator) {
                    $isiIndikator = $unitIsiIndikator->isiIndikator;
                    $pengisian = $pengisianData->get($unitIsiIndikator->id);

                    $reviewAuditor1 = $pengisian?->reviewAuditor1;
                    $reviewAuditor2 = $pengisian?->reviewAuditor2;

                    // Build bukti dokumen text
                    $buktiDokumen = $pengisian?->bukti ?? '-';
                    if ($unitIsiIndikator->bukti) {
                        $buktiDokumen = $unitIsiIndikator->bukti;
                    }

                    // Faktor penghambat
                    $faktorPenghambat = '';
                    if ($pengisian && $pengisian->isi === 'tidak_tercapai') {
                        $faktorPenghambat = $pengisian->faktor_penghambat ?? '-';
                    }

                    // Hasil pengamatan
                    $hasilPengamatan = '';
                    if ($reviewAuditor1 && $reviewAuditor1->status_temuan === 'tidak_sesuai') {
                        $hasilPengamatan = $reviewAuditor1->hasil_pengamatan ?? '-';
                    }

                    // Status temuan checkmarks
                    $auditor1Sesuai = ($reviewAuditor1 && $reviewAuditor1->status_temuan === 'sesuai') ? 'v' : '';
                    $auditor1TidakSesuai = ($reviewAuditor1 && $reviewAuditor1->status_temuan === 'tidak_sesuai') ? 'v' : '';
                    $auditor2Sesuai = ($reviewAuditor2 && $reviewAuditor2->status_temuan === 'sesuai') ? 'v' : '';
                    $auditor2TidakSesuai = ($reviewAuditor2 && $reviewAuditor2->status_temuan === 'tidak_sesuai') ? 'v' : '';

                    $data[] = [
                        $standar->nama_standar,         // A
                        $isiIndikator->isi_indikator,  // B  
                        $indikator->target ?? '-',      // C - TARGET
                        $unitIsiIndikator->pertanyaan ?? '-', // D - PERTANYAAN
                        $buktiDokumen,                  // E - Bukti dokumen
                        $faktorPenghambat,             // F - Faktor penghambat
                        $hasilPengamatan,              // G - Hasil pengamatan
                        $auditor1Sesuai,               // H - Auditor 1 SESUAI
                        $auditor1TidakSesuai,          // I - Auditor 1 TIDAK SESUAI
                        $auditor2Sesuai,               // J - Auditor 2 SESUAI
                        $auditor2TidakSesuai,          // K - Auditor 2 TIDAK SESUAI
                    ];
                }
            }
        }

        return $data;
    }

    public function columnWidths(): array
    {
        return [
            'A' => 22.11,   // NAMA STANDAR
            'B' => 80.33,   // INDIKATOR
            'C' => 15,      // TARGET
            'D' => 30,      // PERTANYAAN
            'E' => 40,      // Bukti dokumen
            'F' => 25,      // Faktor penghambat
            'G' => 40,      // Hasil Pengamatan
            'H' => 8,       // Auditor 1 SESUAI
            'I' => 12,      // Auditor 1 TIDAK SESUAI
            'J' => 8,       // Auditor 2 SESUAI
            'K' => 12,      // Auditor 2 TIDAK SESUAI
        ];
    }

    public function styles(Worksheet $sheet)
    {
        // This will be handled in registerEvents for more complex styling
        return $sheet;
    }

    public function registerEvents(): array
    {
        return [
            AfterSheet::class => function (AfterSheet $event) {
                $sheet = $event->sheet->getDelegate();
                $today = Carbon::now()->format('d M Y');

                // Set up the header section
                $this->setupHeader($sheet, $today);

                // Set up the column headers
                $this->setupColumnHeaders($sheet);

                // Style the data
                $this->styleData($sheet);
            },
        ];
    }

    private function setupHeader($sheet, $today)
    {
        // Title
        $sheet->mergeCells('A1:B1');
        $sheet->setCellValue('A1', 'FORM CHECK-LIST AUDIT');
        $sheet->getStyle('A1')->applyFromArray([
            'font' => ['name' => 'Arial', 'bold' => true, 'size' => 20],
            'alignment' => [
                'horizontal' => Alignment::HORIZONTAL_LEFT,
                'vertical' => Alignment::VERTICAL_CENTER,
                'wrapText' => true
            ],
            'fill' => ['fillType' => Fill::FILL_SOLID, 'startColor' => ['rgb' => 'ACB9CA']],
        ]);

        $sheet->getStyle('A2:A5')->applyFromArray([
            'font' => ['name' => 'Arial', 'bold' => true, 'size' => 11],
            'alignment' => [
                'horizontal' => Alignment::HORIZONTAL_LEFT,
                'vertical' => Alignment::VERTICAL_CENTER,
                'wrapText' => true
            ],
            'fill' => ['fillType' => Fill::FILL_SOLID, 'startColor' => ['rgb' => 'ACB9CA']],
        ]);

        // Apply border to A1:B5 range
        $sheet->getStyle('A1:B5')->applyFromArray([
            'borders' => ['allBorders' => ['borderStyle' => Border::BORDER_THIN]],
        ]);

        // Kode form
        $sheet->setCellValue('A2', 'Kode form:');
        $sheet->getStyle('B2')->applyFromArray([
            'font' => ['name' => 'Arial', 'bold' => false, 'size' => 11],
            'alignment' => [
                'horizontal' => Alignment::HORIZONTAL_LEFT,
                'vertical' => Alignment::VERTICAL_CENTER,
                'wrapText' => true
            ],
            'fill' => ['fillType' => Fill::FILL_SOLID, 'startColor' => ['rgb' => '595959']],
        ]);
        
        // Audit
        $sheet->setCellValue('A3', 'Audit:');

        $sheet->setCellValue('B3', $this->assignPengisian->unitIndikator->unit->nama_unit ?? '-');
$sheet->getStyle('B3:B5')->applyFromArray([
            'font' => ['name' => 'Arial', 'bold' => false, 'size' => 11],
            'alignment' => [
                'horizontal' => Alignment::HORIZONTAL_LEFT,
                'vertical' => Alignment::VERTICAL_CENTER,
                'wrapText' => true
            ],
            'fill' => ['fillType' => Fill::FILL_SOLID, 'startColor' => ['rgb' => 'ACB9CA']],
        ]);

        // Nama Pejabat (auditee)
        $sheet->setCellValue('A4', 'Nama Pejabat (auditee):');
        $sheet->setCellValue('B4', $this->assignPengisian->unitIndikator->auditeeUser->name ?? '-');
        $sheet->getStyle('A4:B4')->applyFromArray([
            'font' => ['name' => 'Arial'],
            'alignment' => ['wrapText' => true],
            'fill' => ['fillType' => Fill::FILL_SOLID, 'startColor' => ['rgb' => 'ACB9CA']],
        ]);

        // Tanggal pengisian
        $sheet->setCellValue('A5', 'Tanggal pengisian:');
        $sheet->setCellValue('B5', $this->assignPengisian->pengisianIndikator->created_at ?? '-');


        // Set row heights for A2-A5
        $sheet->getRowDimension(1)->setRowHeight(39);
        $sheet->getRowDimension(2)->setRowHeight(39);
        $sheet->getRowDimension(3)->setRowHeight(39);
        $sheet->getRowDimension(4)->setRowHeight(39);
        $sheet->getRowDimension(5)->setRowHeight(39);
        $sheet->getRowDimension(6)->setRowHeight(13.8);


        }

    private function setupColumnHeaders($sheet)
    {
        // Main headers row 7
        $sheet->setCellValue('A7', 'NAMA STANDAR');
        $sheet->setCellValue('B7', 'INDIKATOR');
        $sheet->setCellValue('C7', 'TARGET');
        $sheet->setCellValue('D7', $this->assignPengisian->unitIndikator->unit->kode_unit ?? '045');
        
        $sheet->setCellValue('E7', 'KOLOM PENGISIAN KONDISI AUDITI');
        $sheet->mergeCells('E7:G7');
        
        $sheet->setCellValue('H7', 'Di-isi Oleh AUDITOR');
        $sheet->mergeCells('H7:K7');

        // Sub headers row 8 - merge A7:A8 and B7:B8 for spanning
        $sheet->mergeCells('A7:A8');
        $sheet->mergeCells('B7:B8');
        $sheet->mergeCells('C7:C8');
        $sheet->mergeCells('D7:D8');
        
        // KOLOM PENGISIAN KONDISI AUDITI sub headers
        $sheet->setCellValue('E8', 'Bukti dokumen (dapat di-isikan dengan link / bukti nomor dokumen / penjelasan yang mendukung)');
        $sheet->setCellValue('F8', 'Faktor penghambat (di-isi jika standar tidak tercapai)');
        $sheet->setCellValue('G8', 'Hasil Pengamatan (di-isikan uraian singkat kondisi prodi terhadap pertanyaan JIKA STATUS TEMUAN: TIDAK SESUAI)');

        // Auditor columns
        $auditor1Name = $this->assignPengisian->assignAuditors?->auditor1Relation?->name ?? 'Auditor 1';
        $auditor2Name = $this->assignPengisian->assignAuditors?->auditor2Relation?->name ?? 'Auditor 2';

        $sheet->setCellValue('H8', 'Nama Auditor:');
        $sheet->setCellValue('I8', "(isi nama auditor 1)\n{$auditor1Name}");
        $sheet->setCellValue('J8', "(isi nama auditor 2)\n{$auditor2Name}");
        $sheet->mergeCells('I8:J8');

        // Status columns row 9
        $sheet->setCellValue('H9', 'Status temuan (isi dengan "v") jika');
        $sheet->setCellValue('I9', 'SESUAI');
        $sheet->setCellValue('J9', 'TIDAK SESUAI');
        $sheet->setCellValue('K9', 'SESUAI');
        $sheet->setCellValue('L9', 'TIDAK SESUAI');

        // Styling for main headers (row 7)
        $sheet->getStyle('A7:D7')->applyFromArray([
            'font' => ['name' => 'Arial', 'bold' => true, 'size' => 11],
            'alignment' => [
                'horizontal' => Alignment::HORIZONTAL_CENTER,
                'vertical' => Alignment::VERTICAL_CENTER,
                'wrapText' => true
            ],
            'fill' => ['fillType' => Fill::FILL_SOLID, 'startColor' => ['rgb' => 'FFFF00']],
            'borders' => ['allBorders' => ['borderStyle' => Border::BORDER_THIN]],
        ]);

        // Styling for KOLOM PENGISIAN KONDISI AUDITI section
        $sheet->getStyle('E7:G9')->applyFromArray([
            'font' => ['name' => 'Arial', 'bold' => true, 'size' => 9],
            'alignment' => [
                'horizontal' => Alignment::HORIZONTAL_CENTER,
                'vertical' => Alignment::VERTICAL_CENTER,
                'wrapText' => true
            ],
            'fill' => ['fillType' => Fill::FILL_SOLID, 'startColor' => ['rgb' => '92D050']],
            'borders' => ['allBorders' => ['borderStyle' => Border::BORDER_THIN]],
        ]);

        // Styling for AUDITOR section
        $sheet->getStyle('H7:L9')->applyFromArray([
            'font' => ['name' => 'Arial', 'bold' => true, 'size' => 9],
            'alignment' => [
                'horizontal' => Alignment::HORIZONTAL_CENTER,
                'vertical' => Alignment::VERTICAL_CENTER,
                'wrapText' => true
            ],
            'fill' => ['fillType' => Fill::FILL_SOLID, 'startColor' => ['rgb' => '92D050']],
            'borders' => ['allBorders' => ['borderStyle' => Border::BORDER_THIN]],
        ]);

        // Set row heights
        $sheet->getRowDimension(7)->setRowHeight(25);
        $sheet->getRowDimension(8)->setRowHeight(50);
        $sheet->getRowDimension(9)->setRowHeight(25);
    }

    private function styleData($sheet)
    {
        $lastRow = $sheet->getHighestRow();

        if ($lastRow > 9) {
            // Data styling
            $sheet->getStyle("A10:K{$lastRow}")->applyFromArray([
                'font' => ['name' => 'Arial', 'size' => 10],
                'borders' => ['allBorders' => ['borderStyle' => Border::BORDER_THIN]],
                'alignment' => [
                    'vertical' => Alignment::VERTICAL_TOP,
                    'wrapText' => true
                ],
            ]);

            // Center align checkmark columns (H to K)
            $sheet->getStyle("H10:K{$lastRow}")->getAlignment()->setHorizontal(Alignment::HORIZONTAL_CENTER);
        }
    }
}

class AnalisisKetercapaianSheet implements FromArray, WithHeadings, WithStyles, WithColumnWidths, WithEvents, WithTitle
{
    protected $assignPengisian;

    public function __construct(AssignPengisian $assignPengisian)
    {
        $this->assignPengisian = $assignPengisian;
    }

    public function title(): string
    {
        return 'Analisis Ketercapaian';
    }

    public function headings(): array
    {
        return [
            'Standar',
            'Sub Standar',
            'Total Item',
            'Tercapai (Auditee)',
            '% Tercapai (Auditee)',
            'Tidak Tercapai (Auditee)',
            '% Tidak Tercapai (Auditee)',
            'Belum Diisi',
            '% Belum Diisi',
            'Sesuai (Auditor 1)',
            '% Sesuai (Auditor 1)',
            'Tidak Sesuai (Auditor 1)',
            '% Tidak Sesuai (Auditor 1)',
            'Belum Review (Auditor 1)',
            'Tingkat Kesepakatan (%)',
            'Status Kualitas',
        ];
    }

    public function array(): array
    {
        $data = [];
        $pengisianData = $this->assignPengisian->pengisianIndikators->keyBy('ui_isi_indikator_id');

        // Group by Standar and Sub Standar
        $grouped = [];
        foreach ($this->assignPengisian->unitIndikator->unitIndikatorStandars as $unitStandar) {
            $standar = $unitStandar->standar;

            foreach ($unitStandar->unitIndikatorIndikators as $unitIndikator) {
                $indikator = $unitIndikator->indikator;
                $subStandar = $indikator->subStandar;

                $standarKey = $standar->nama_standar;
                $subStandarKey = $subStandar?->nama_sub_standar ?? 'Tanpa Sub Standar';

                if (!isset($grouped[$standarKey])) {
                    $grouped[$standarKey] = [];
                }

                if (!isset($grouped[$standarKey][$subStandarKey])) {
                    $grouped[$standarKey][$subStandarKey] = [
                        'total' => 0,
                        'tercapai' => 0,
                        'tidak_tercapai' => 0,
                        'belum_diisi' => 0,
                        'auditor1_sesuai' => 0,
                        'auditor1_tidak_sesuai' => 0,
                        'auditor1_belum_review' => 0,
                    ];
                }

                foreach ($unitIndikator->unitIndikatorIsiIndikators as $unitIsiIndikator) {
                    $pengisian = $pengisianData->get($unitIsiIndikator->id);
                    $reviewAuditor1 = $pengisian?->reviewAuditor1;

                    $grouped[$standarKey][$subStandarKey]['total']++;

                    // Pengisian Auditee
                    if ($pengisian && $pengisian->isi) {
                        if ($pengisian->isi === 'tercapai') {
                            $grouped[$standarKey][$subStandarKey]['tercapai']++;
                        } else {
                            $grouped[$standarKey][$subStandarKey]['tidak_tercapai']++;
                        }
                    } else {
                        $grouped[$standarKey][$subStandarKey]['belum_diisi']++;
                    }

                    // Review Auditor 1
                    if ($reviewAuditor1 && $reviewAuditor1->status === 'reviewed') {
                        if ($reviewAuditor1->status_temuan === 'sesuai') {
                            $grouped[$standarKey][$subStandarKey]['auditor1_sesuai']++;
                        } else {
                            $grouped[$standarKey][$subStandarKey]['auditor1_tidak_sesuai']++;
                        }
                    } else {
                        $grouped[$standarKey][$subStandarKey]['auditor1_belum_review']++;
                    }
                }
            }
        }

        // Convert to array format
        foreach ($grouped as $standarName => $subStandars) {
            foreach ($subStandars as $subStandarName => $stats) {
                $total = $stats['total'];

                // Calculate percentages
                $pctTercapai = $total > 0 ? round(($stats['tercapai'] / $total) * 100, 2) : 0;
                $pctTidakTercapai = $total > 0 ? round(($stats['tidak_tercapai'] / $total) * 100, 2) : 0;
                $pctBelumDisii = $total > 0 ? round(($stats['belum_diisi'] / $total) * 100, 2) : 0;
                $pctAuditor1Sesuai = $total > 0 ? round(($stats['auditor1_sesuai'] / $total) * 100, 2) : 0;
                $pctAuditor1TidakSesuai = $total > 0 ? round(($stats['auditor1_tidak_sesuai'] / $total) * 100, 2) : 0;

                // Calculate agreement rate (simplified)
                $agreementRate = $total > 0 ? round((($stats['tercapai'] + $stats['auditor1_sesuai']) / ($total * 2)) * 100, 2) : 0;

                // Determine quality status
                $qualityStatus = '';
                if ($agreementRate >= 90) {
                    $qualityStatus = 'Sangat Baik';
                } elseif ($agreementRate >= 75) {
                    $qualityStatus = 'Baik';
                } elseif ($agreementRate >= 60) {
                    $qualityStatus = 'Cukup';
                } else {
                    $qualityStatus = 'Perlu Perbaikan';
                }

                $data[] = [
                    $standarName,
                    $subStandarName,
                    $total,
                    $stats['tercapai'],
                    $pctTercapai,
                    $stats['tidak_tercapai'],
                    $pctTidakTercapai,
                    $stats['belum_diisi'],
                    $pctBelumDisii,
                    $stats['auditor1_sesuai'],
                    $pctAuditor1Sesuai,
                    $stats['auditor1_tidak_sesuai'],
                    $pctAuditor1TidakSesuai,
                    $stats['auditor1_belum_review'],
                    $agreementRate,
                    $qualityStatus,
                ];
            }
        }

        return $data;
    }

    public function columnWidths(): array
    {
        return [
            'A' => 25,
            'B' => 20,
            'C' => 12,
            'D' => 15,
            'E' => 18,
            'F' => 18,
            'G' => 22,
            'H' => 12,
            'I' => 15,
            'J' => 15,
            'K' => 18,
            'L' => 18,
            'M' => 22,
            'N' => 18,
            'O' => 20,
            'P' => 15,
        ];
    }

    public function styles(Worksheet $sheet)
    {
        // Header styling
        $sheet->getStyle('A1:P1')->applyFromArray([
            'font' => [
                'name' => 'Arial',
                'bold' => true,
                'size' => 11,
                'color' => ['rgb' => 'FFFFFF'],
            ],
            'fill' => [
                'fillType' => Fill::FILL_SOLID,
                'startColor' => ['rgb' => '4472C4'],
            ],
            'borders' => [
                'allBorders' => [
                    'borderStyle' => Border::BORDER_THIN,
                ],
            ],
            'alignment' => [
                'horizontal' => Alignment::HORIZONTAL_CENTER,
                'vertical' => Alignment::VERTICAL_CENTER,
                'wrapText' => true,
            ],
        ]);

        // Data styling
        $lastRow = $sheet->getHighestRow();
        $sheet->getStyle("A2:P{$lastRow}")->applyFromArray([
            'font' => ['name' => 'Arial', 'size' => 10],
            'borders' => [
                'allBorders' => [
                    'borderStyle' => Border::BORDER_THIN,
                ],
            ],
            'alignment' => [
                'vertical' => Alignment::VERTICAL_CENTER,
                'wrapText' => true,
            ],
        ]);

        // Format percentage columns
        $sheet->getStyle("E2:E{$lastRow}")->getNumberFormat()->setFormatCode('0.00"%"');
        $sheet->getStyle("G2:G{$lastRow}")->getNumberFormat()->setFormatCode('0.00"%"');
        $sheet->getStyle("I2:I{$lastRow}")->getNumberFormat()->setFormatCode('0.00"%"');
        $sheet->getStyle("K2:K{$lastRow}")->getNumberFormat()->setFormatCode('0.00"%"');
        $sheet->getStyle("M2:M{$lastRow}")->getNumberFormat()->setFormatCode('0.00"%"');
        $sheet->getStyle("O2:O{$lastRow}")->getNumberFormat()->setFormatCode('0.00"%"');

        // Color coding for different sections
        $sheet->getStyle('D1:I1')->getFill()->setFillType(Fill::FILL_SOLID)->getStartColor()->setRGB('70AD47');
        $sheet->getStyle('J1:N1')->getFill()->setFillType(Fill::FILL_SOLID)->getStartColor()->setRGB('FFC000');
        $sheet->getStyle('O1:P1')->getFill()->setFillType(Fill::FILL_SOLID)->getStartColor()->setRGB('7030A0');

        return $sheet;
    }

    public function registerEvents(): array
    {
        return [
            AfterSheet::class => function (AfterSheet $event) {
                $sheet = $event->sheet->getDelegate();

                // Freeze header row
                $sheet->freezePane('A2');

                // Set row height for header
                $sheet->getRowDimension(1)->setRowHeight(40);

                // Add chart if data exists
                if ($sheet->getHighestRow() > 1) {
                    $this->addChart($sheet);
                }
            },
        ];
    }

    private function addChart(Worksheet $sheet)
    {
        $lastRow = $sheet->getHighestRow();

        if ($lastRow < 2) return;

        $dataSeriesLabels = [
            new DataSeriesValues(DataSeriesValues::DATASERIES_TYPE_STRING, 'Analisis Ketercapaian!$E$1', null, 1),
            new DataSeriesValues(DataSeriesValues::DATASERIES_TYPE_STRING, 'Analisis Ketercapaian!$G$1', null, 1),
        ];

        $xAxisTickValues = [
            new DataSeriesValues(DataSeriesValues::DATASERIES_TYPE_STRING, "Analisis Ketercapaian!\$A\$2:\$A\${$lastRow}", null, $lastRow - 1),
        ];

        $dataSeriesValues = [
            new DataSeriesValues(DataSeriesValues::DATASERIES_TYPE_NUMBER, "Analisis Ketercapaian!\$E\$2:\$E\${$lastRow}", null, $lastRow - 1),
            new DataSeriesValues(DataSeriesValues::DATASERIES_TYPE_NUMBER, "Analisis Ketercapaian!\$G\$2:\$G\${$lastRow}", null, $lastRow - 1),
        ];

        $series = new DataSeries(
            DataSeries::TYPE_BARCHART,
            DataSeries::GROUPING_CLUSTERED,
            range(0, count($dataSeriesValues) - 1),
            $dataSeriesLabels,
            $xAxisTickValues,
            $dataSeriesValues
        );

        $plotArea = new PlotArea(null, [$series]);
        $legend = new Legend(Legend::POSITION_BOTTOM, null, false);
        $title = new Title('Persentase Ketercapaian per Standar');

        $chart = new Chart(
            'chart1',
            $title,
            $legend,
            $plotArea,
            true,
            0,
            null,
            null
        );

        $chart->setTopLeftPosition('R2');
        $chart->setBottomRightPosition('Z20');

        $sheet->addChart($chart);
    }
}

// Usage in ViewAuditResult.php - Add this method
class ExportAuditResultAction
{
    public static function make(): \Filament\Actions\Action
    {
        return \Filament\Actions\Action::make('export_audit_result')
            ->label('Export Excel')
            ->icon('heroicon-o-arrow-down-tray')
            ->color('success')
            ->action(function (array $data, $livewire) {
                $assignment = $livewire->assignment;

                $fileName = 'audit-result-' . $assignment->unitIndikator->unit->nama_unit . '-' .
                    $assignment->periode->periode_name . '-' . now()->format('Y-m-d') . '.xlsx';

                return \Maatwebsite\Excel\Facades\Excel::download(
                    new AuditResultExport($assignment),
                    $fileName
                );
            });
    }
}
