<?php

namespace Database\Seeders;

use App\Models\Unit;
use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;
use Faker\Factory as Faker;
use Spatie\Permission\Models\Role;

class AuditorSeeder extends Seeder
{
    public function run(): void
    {
        $faker = Faker::create('id_ID'); // Indonesian locale for more appropriate emails
        
        // Ensure auditor role exists
        $auditorRole = Role::firstOrCreate(['name' => 'auditor', 'guard_name' => 'web']);
        
        $auditorData = [
            ['nip' => '1', 'name' => 'Pritantina Yuni Lestari S.Pd., M,Pd.', 'unit_name' => 'JURUSAN ADMINISTRASI NIAGA'],
            ['nip' => '2', 'name' => 'Maskur, S.Kom., M.Kom.', 'unit_name' => 'JURUSAN ADMINISTRASI NIAGA'],
            ['nip' => '3', 'name' => 'Rachma Bhakti Utami S.E., M.AB', 'unit_name' => 'JURUSAN ADMINISTRASI NIAGA'],
            ['nip' => '4', 'name' => 'Dr., Drs., Mohammad Maskan, M.SI.', 'unit_name' => 'JURUSAN ADMINISTRASI NIAGA'],
            ['nip' => '5', 'name' => 'Tiara Estu Amanda, S.S., M.Par.', 'unit_name' => 'JURUSAN ADMINISTRASI NIAGA'],
            ['nip' => '6', 'name' => 'Dra. Eni Widyowati M.Pd.', 'unit_name' => 'JURUSAN ADMINISTRASI NIAGA'],
            ['nip' => '7', 'name' => 'Dr. Drs. Sumiadji, Ak., M.SA.', 'unit_name' => 'JURUSAN AKUNTANSI'],
            ['nip' => '8', 'name' => 'Muhammad Kholisul Imam S.E., M.E', 'unit_name' => 'JURUSAN AKUNTANSI'],
            ['nip' => '9', 'name' => 'Padma adriana sari, SE., MSA., Ak.', 'unit_name' => 'JURUSAN AKUNTANSI'],
            ['nip' => '10', 'name' => 'Rika Wijayanti, S.Pd. M.Ak.', 'unit_name' => 'JURUSAN AKUNTANSI'],
            ['nip' => '11', 'name' => 'Ikhsan Setiawan S.Pd.I., M.Pd.', 'unit_name' => 'JURUSAN TEKNIK ELEKTRO'],
            ['nip' => '12', 'name' => 'Drs. Bambang Budiprayitno., AK., M.SI.', 'unit_name' => 'JURUSAN AKUNTANSI'],
            ['nip' => '13', 'name' => 'Dr. Drs. Ludfi Djajanto, MBA', 'unit_name' => 'JURUSAN AKUNTANSI'],
            ['nip' => '14', 'name' => 'Aditya Arisudhana S.E., Akt., M.Acc., CPA', 'unit_name' => 'JURUSAN AKUNTANSI'],
            ['nip' => '15', 'name' => 'Elvyra Handayani Soedarso, S.E., M.SA.', 'unit_name' => 'JURUSAN AKUNTANSI'],
            ['nip' => '16', 'name' => 'Ir. Mohammad Luqman, MS.', 'unit_name' => 'JURUSAN TEKNIK ELEKTRO'],
            ['nip' => '17', 'name' => 'Ir. Waluyo, MT', 'unit_name' => 'JURUSAN TEKNIK ELEKTRO'],
            ['nip' => '18', 'name' => 'Amalia Eka Rakhmania, ST, MT., M.Sc.', 'unit_name' => 'JURUSAN TEKNIK ELEKTRO'],
            ['nip' => '19', 'name' => 'Asfari Hariz Santoso, ST., MT.', 'unit_name' => 'JURUSAN TEKNIK ELEKTRO'],
            ['nip' => '20', 'name' => 'Doddy Maulana, SE, MT. M.Sc.', 'unit_name' => 'JURUSAN TEKNIK ELEKTRO'],
            ['nip' => '21', 'name' => 'Mila Kusuma Wardhani S.T., M.T.', 'unit_name' => 'JURUSAN TEKNIK ELEKTRO'],
            ['nip' => '22', 'name' => 'Mila Fauziyah., ST., MT.', 'unit_name' => 'JURUSAN TEKNIK ELEKTRO'],
            ['nip' => '23', 'name' => 'Listiyana Candra Dewi S.Si., M.Si', 'unit_name' => 'JURUSAN TEKNIK KIMIA'],
            ['nip' => '24', 'name' => 'Dr. Dyah Ratna Wulan S.Si.,M.Si', 'unit_name' => 'JURUSAN TEKNIK KIMIA'],
            ['nip' => '25', 'name' => 'Wahyuni Ningsih S.Si., M.Si.', 'unit_name' => 'JURUSAN TEKNIK KIMIA'],
            ['nip' => '26', 'name' => 'Profiyanti Hermien Suharti S.T., M.T', 'unit_name' => 'JURUSAN TEKNIK KIMIA'],
            ['nip' => '27', 'name' => 'Noor Isnaini Azkiya, S.Si., M.Si.', 'unit_name' => 'JURUSAN TEKNIK KIMIA'],
            ['nip' => '28', 'name' => 'Dr. Ir. Ariani, MT.', 'unit_name' => 'JURUSAN TEKNIK KIMIA'],
            ['nip' => '29', 'name' => 'Prof. Dr. Ir. Dwina Moentamaria, M.T.', 'unit_name' => 'JURUSAN TEKNIK KIMIA'],
            ['nip' => '30', 'name' => 'Santoso, S.T.,M.T.', 'unit_name' => 'JURUSAN TEKNIK MESIN'],
            ['nip' => '31', 'name' => 'Dr. Drs. Moh. Hartono, M.T.', 'unit_name' => 'JURUSAN TEKNIK MESIN'],
            ['nip' => '32', 'name' => 'Dr. Wirawan, B.Eng.(Hons.), M.T.', 'unit_name' => 'JURUSAN TEKNIK MESIN'],
            ['nip' => '33', 'name' => 'Kris Witono S.T., M.T.', 'unit_name' => 'JURUSAN TEKNIK MESIN'],
            ['nip' => '34', 'name' => 'Novita Anggraini, SST., MT', 'unit_name' => 'JURUSAN TEKNIK SIPIL'],
            ['nip' => '35', 'name' => 'Winda Harsanti, ST., MT.', 'unit_name' => 'JURUSAN TEKNIK SIPIL'],
            ['nip' => '36', 'name' => 'Moch. Sholeh, ST. MT.', 'unit_name' => 'JURUSAN TEKNIK SIPIL'],
            ['nip' => '37', 'name' => 'Ikrar Hanggara, ST., MT.', 'unit_name' => 'JURUSAN TEKNIK SIPIL'],
            ['nip' => '38', 'name' => 'Luqman Affandi S.Kom.,MMSI', 'unit_name' => 'JURUSAN TEKNOLOGI INFORMASI'],
            ['nip' => '39', 'name' => 'Septian Enggar Sukmana, S.Pd., M.T.', 'unit_name' => 'JURUSAN TEKNOLOGI INFORMASI'],
            ['nip' => '40', 'name' => 'Ade Ismail, S.Kom., M.TI.', 'unit_name' => 'JURUSAN TEKNOLOGI INFORMASI'],
            ['nip' => '41', 'name' => 'Budi Harijanto, ST., M.Mkom.', 'unit_name' => 'JURUSAN TEKNOLOGI INFORMASI'],
            ['nip' => '42', 'name' => 'Dr. Widaningsih S.Psi., S.H., M.H.', 'unit_name' => 'JURUSAN TEKNOLOGI INFORMASI'],
            ['nip' => '43', 'name' => 'Farid Angga Pribadi, S.Kom., M.Kom.', 'unit_name' => 'JURUSAN TEKNOLOGI INFORMASI'],
            ['nip' => '44', 'name' => 'Retno Damayanti S.Pd., M.T.', 'unit_name' => 'JURUSAN TEKNOLOGI INFORMASI'],
            ['nip' => '45', 'name' => 'Yoppy Yunhasnawa S.ST., M.Sc.', 'unit_name' => 'JURUSAN TEKNOLOGI INFORMASI'],
            ['nip' => '46', 'name' => 'Riswan Eko Wahyu Susanto S.Pd., M.T.', 'unit_name' => 'PSDKU KEDIRI'],
            ['nip' => '47', 'name' => 'Mochamad Muzaki, ST. MT.', 'unit_name' => 'JURUSAN TEKNIK MESIN'],
            ['nip' => '48', 'name' => 'Masfufah', 'unit_name' => 'Kepala P2MPP'],
            ['nip' => '49', 'name' => 'Lita Berlianti Imaniar', 'unit_name' => 'Kepala P2MPP'],
            ['nip' => '50', 'name' => 'Andini Galih Widya Putri', 'unit_name' => 'Kepala P2MPP'],
        ];

        $createdCount = 0;
        $skippedCount = 0;
        $notFoundUnits = [];

        foreach ($auditorData as $data) {
            $nip = str_pad($data['nip'], 8, '0', STR_PAD_LEFT); // Format NIP to 8 digits
            $name = $data['name'];
            $unitName = $data['unit_name'];

            // Find the unit by name
            $unit = Unit::where('nama_unit', $unitName)->first();
            
            if (!$unit) {
                $notFoundUnits[] = $unitName;
                $this->command->error("Unit not found: {$unitName} for NIP {$nip}");
                continue;
            }

            // Check if user already exists
            $existingUser = User::where('nip', $nip)->first();
            if ($existingUser) {
                $skippedCount++;
                $this->command->warn("Skipped: User with NIP {$nip} already exists");
                continue;
            }

            // Generate fake email (keep using faker for emails)
            $email = $faker->unique()->safeEmail();

            // Create the user
            $user = User::create([
                'nip' => $nip,
                'name' => $name,
                'email' => $email,
                'password' => Hash::make('password'), // Default password
                'unit_id' => $unit->id,
            ]);

            // Assign auditor role
            $user->assignRole('auditor');

            $createdCount++;
            $this->command->info("Created auditor: NIP {$nip} - {$name} ({$unitName})");
        }

        // Summary
        $this->command->info("\n=== Auditor Seeder Summary ===");
        $this->command->info("Created: {$createdCount} auditors");
        $this->command->info("Skipped: {$skippedCount} auditors (already existed)");
        
        if (!empty($notFoundUnits)) {
            $this->command->error("Units not found: " . implode(', ', array_unique($notFoundUnits)));
            $this->command->error("Please run UnitSeeder first or check unit names");
        }

        $this->command->info("All auditors have default password: 'password'");
    }
}