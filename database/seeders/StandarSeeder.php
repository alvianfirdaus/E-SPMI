<?php

namespace Database\Seeders;

use App\Models\Standar;
use App\Models\User;
use Illuminate\Database\Seeder;

class StandarSeeder extends Seeder
{
    public function run(): void
    {
        $currentYear = date('Y');
        
        // Get super admin for validated_by
        $superAdmin = User::where('email', 'admin@example.com')->first();
        
        $standardData = [
            ['kode' => 'STD-001', 'nama' => 'Standar Kompetensi lulusan'],
            ['kode' => 'STD-002', 'nama' => 'Standar Isi Pembelajaran'],
            ['kode' => 'STD-003', 'nama' => 'Standar Proses Pembelajaran'],
            ['kode' => 'STD-004', 'nama' => 'Standar Penilaian Pembelajaran'],
            ['kode' => 'STD-005', 'nama' => 'Standar Pendidik dan Tenaga Kependidikan'],
            ['kode' => 'STD-006', 'nama' => 'Standar Sarana dan Prasarana Pembelajaran'],
            ['kode' => 'STD-007', 'nama' => 'Standar Pengelolaan Pembelajaran'],
            ['kode' => 'STD-008', 'nama' => 'Standar Pendanaan dan Pembiayaan Pembelajaran'],
            ['kode' => 'STD-009', 'nama' => 'Standar Hasil Penelitian'],
            ['kode' => 'STD-010', 'nama' => 'Standar Isi Penelitian'],
            ['kode' => 'STD-011', 'nama' => 'Standar Proses Penelitian'],
            ['kode' => 'STD-012', 'nama' => 'Standar Penilaian Penelitian'],
            ['kode' => 'STD-013', 'nama' => 'Standar Peneliti'],
            ['kode' => 'STD-014', 'nama' => 'Standar Sarana dan Prasarana Penelitian'],
            ['kode' => 'STD-015', 'nama' => 'Standar Pengelolaan Penelitian'],
            ['kode' => 'STD-016', 'nama' => 'Standar Pendanaan dan Pembiayaan Penelitian'],
            ['kode' => 'STD-017', 'nama' => 'Standar Hasil Pengabdian kepada Masyarakat'],
            ['kode' => 'STD-018', 'nama' => 'Standar Isi Pengabdian kepada Masyarakat'],
            ['kode' => 'STD-019', 'nama' => 'Standar Proses Pengabdian kepada Masyarakat'],
            ['kode' => 'STD-020', 'nama' => 'Standar Penilaian Pengabdian kepada Masyarakat'],
            ['kode' => 'STD-021', 'nama' => 'Standar Pelaksana Pengabdian kepada Masyarakat'],
            ['kode' => 'STD-022', 'nama' => 'Standar Sarana dan Prasarana Pengabdian kepada Masyarakat'],
            ['kode' => 'STD-023', 'nama' => 'Standar Pengelolaan Pengabdian kepada Masyarakat'],
            ['kode' => 'STD-024', 'nama' => 'Standar Pendanaan dan Pembiayaan Pengabdian kepada Masyarakat'],
            ['kode' => 'STD-025', 'nama' => 'Standar Perpustakaan'],
            ['kode' => 'STD-027', 'nama' => 'Standar Penerimaan Mahasiswa Baru'],
            ['kode' => 'STD-028', 'nama' => 'Standar Kemahasiswaan'],
            ['kode' => 'STD-030', 'nama' => 'Standar Alumni'],
            ['kode' => 'STD-031', 'nama' => 'Standar Visi, Misi, Tujuan dan Sasaran'],
            ['kode' => 'STD-034', 'nama' => 'Standar Pengelolaan Institusi'],
            ['kode' => 'STD-037', 'nama' => 'Standar Alih Jenjang'],
            ['kode' => 'STD-038', 'nama' => 'Standar Rekognisi Pembelajaran Lampau (A1)'],
            ['kode' => 'STD-039', 'nama' => 'Standar Kompetensi Lulusan Dalam Berbahasa Inggris'],
            ['kode' => 'STD-040', 'nama' => 'Standar E-Learning'],
            ['kode' => 'STD-041', 'nama' => 'Standar Kompetensi Kerja Nasional'],
        ];

        $createdCount = 0;
        $skippedCount = 0;

        foreach ($standardData as $data) {
            // Check if standard already exists
            $existingStandar = Standar::where('kode_standar', $data['kode'])
                                    ->orWhere('nama_standar', $data['nama'])
                                    ->first();
            
            if ($existingStandar) {
                $skippedCount++;
                $this->command->warn("Skipped: {$data['kode']} - {$data['nama']} (already exists)");
                continue;
            }

            // Create the standard
            Standar::create([
                'kode_standar' => $data['kode'],
                'nama_standar' => $data['nama'],
                'tahun' => $currentYear,
                'status' => 'validated',
                'validated_by' => $superAdmin ? $superAdmin->id : null,
                'validated_time' => now(),
                'created_by' => $superAdmin ? $superAdmin->id : null,
            ]);

            $createdCount++;
            $this->command->info("Created: {$data['kode']} - {$data['nama']}");
        }

        // Summary
        $this->command->info("\n=== Standar Seeder Summary ===");
        $this->command->info("Created: {$createdCount} standards");
        $this->command->info("Skipped: {$skippedCount} standards (already existed)");
        $this->command->info("Year: {$currentYear}");
        $this->command->info("Status: All standards are validated");
    }
}