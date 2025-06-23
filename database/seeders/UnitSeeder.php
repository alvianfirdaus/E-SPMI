<?php

namespace Database\Seeders;

use App\Models\Unit;
use Illuminate\Database\Seeder;

class UnitSeeder extends Seeder
{
    public function run(): void
    {
        // Clean list of unique units from your original data
        $uniqueUnits = [
            'D3 Administrasi Bisnis',
            'D4 Bahasa Inggris Untuk Industri Pariwisata',
            'D4 Bahasa Inggris Untuk Komunikasi Bisnis Dan Profesional',
            'D4 Manajemen Pemasaran',
            'D4 Pengelolaan Arsip Dan Rekaman Informasi',
            'D4 Usaha Perjalanan Wisata',
            'JURUSAN ADMINISTRASI NIAGA',
            'D3 Akuntansi',
            'D4 Akuntansi Manajemen',
            'D4 Keuangan',
            'S2 Magister Terapan Sistem Informasi Akuntansi',
            'JURUSAN AKUNTANSI',
            'D3 Teknik Elektronika',
            'D4 Sistem Kelistrikan',
            'D4 Teknik Elektronika',
            'D4 Teknik Jaringan Telekomunikasi Digital',
            'D3 Teknik Listrik',
            'D3 Teknik Telekomunikasi',
            'S2 Magister Terapan Teknik Elektro',
            'JURUSAN TEKNIK ELEKTRO',
            'D2 Pengembangan Piranti Lunak Situs',
            'D4 Sistem Informsi Bisnis',
            'D4 Teknik Informatika',
            'S2 Magister Terapan Rekayasa Teknologi Informatika',
            'JURUSAN TEKNOLOGI INFORMASI',
            'D3 Teknik Kimia',
            'D4 Teknologi Kimia Industri',
            'S2 Magister Terapan Optimasi Rekayasa Kimia',
            'JURUSAN TEKNIK KIMIA',
            'D3 Teknik Mesin',
            'D3 Teknologi Pemeliharaan Pesawat Udara',
            'D4 Teknik Mesin Produksi Dan Perawatan',
            'D4 Teknik Otomotif Elektronik',
            'S2 Magister Terapan Rekayasa Teknologi Manufaktur',
            'S3 Doktor Terapan Optimasi Desain Mekanik',
            'JURUSAN TEKNIK MESIN',
            'D3 Teknik Sipil',
            'D3 Teknologi Konstruksi, Jalan, Jembatan Dan Bangunan Air',
            'D3 Teknologi Pertambangan',
            'D4 Manajemen Rekayasa Konstruksi',
            'D4 Teknologi Rekayasa Konstruksi Jalan Dan Jembatan',
            'JURUSAN TEKNIK SIPIL',
            'D3 Akuntansi Kampus Kediri',
            'D3 Manajemen Informatika Kampus Kediri',
            'D3 Teknik Mesin Kampus Kediri',
            'D4 Keuangan Kampus Kediri',
            'D4 Teknik Elektronika Kampus Kediri',
            'D4 Teknik Mesin Produksi Dan Perawatan Kampus Kediri',
            'PSDKU KEDIRI',
            'D3 Akuntansi Kampus Lumajang',
            'D3 Teknologi Informasi Kampus Lumajang',
            'D3 Teknologi Sipil Kampus Lumajang',
            'D4 Teknologi Rekayasa Otomotif Kampus Lumajang',
            'PSDKU LUMAJANG',
            'D3 Manajemen Informatika Kampus Pamekasan',
            'D4 Akuntansi Manajemen Kampus Pamekasan',
            'D4 Teknik Otomotif Elektronik Kampus Pamekasan',
            'PSDKU PAMEKASAN',
            'Kepala Bagian Akademik dan Kemahasiswaan (BAK)',
            'Kepala Bagian Perencanaan, Keuangan Dan Umum (BPKU)',
            'Kepala P2MPP',
            'Kepala Pusat Penelitian Dan Pengabdian Kepada Masyarakat (P3M)',
            'Kepala Unit Penunjang Akademik Perpustakaan (UPA Perpustakaan)',
            'Kepala Unit Penunjang Teknologi Informasi Dan Komunikasi (UPA TIK)',
            'Kepala UPA Bahasa',
            'Kepala UPA Layanan Uji Kompetensi (LUK)',
            'Kepala UPA Perawatan dan Perbaikan (PP)',
            'Kepala UPA Pengembangan Karir dan Kewirausahaan (PKK)',
            'Kepala UPA Percetakan dan Penerbitan',
            'PUSAT',
        ];

        $createdCount = 0;
        $skippedCount = 0;

        foreach ($uniqueUnits as $index => $unitName) {
            $kodeUnit = str_pad($index + 1, 3, '0', STR_PAD_LEFT);
            
            // Use firstOrCreate to safely handle duplicates
            $unit = Unit::firstOrCreate(
                ['nama_unit' => $unitName], // Search criteria
                [ // Data to create if not found
                    'kode_unit' => $kodeUnit,
                    'status' => 'validated',
                    'validated_time' => now(),
                ]
            );

            if ($unit->wasRecentlyCreated) {
                $createdCount++;
                $this->command->info("Created: {$kodeUnit} - {$unitName}");
            } else {
                $skippedCount++;
                $this->command->warn("Skipped: {$unit->kode_unit} - {$unitName} (already exists)");
            }
        }

        $this->command->info("\n=== Unit Seeder Summary ===");
        $this->command->info("Created: {$createdCount} units");
        $this->command->info("Skipped: {$skippedCount} units (already existed)");
        $this->command->info("Total processed: " . count($uniqueUnits) . " units");
    }
}