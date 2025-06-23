<?php

namespace Database\Seeders;

use App\Models\Unit;
use App\Models\User;
// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Faker\Factory as Faker;
use Spatie\Permission\Models\Role;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        $this->command->info('🚀 Starting database seeding...');

        // 1. Create roles first
        $this->command->info('📝 Creating roles...');
        $roles = ['super_admin', 'pimpinan', 'p2mpp', 'auditee', 'auditor'];
        foreach ($roles as $role) {
            Role::firstOrCreate(
                ['name' => $role, 'guard_name' => 'web']
            );
        }
        $this->command->info('✅ Roles created successfully');

        // 2. Seed units first (dependency untuk users)
        $this->command->info('🏢 Seeding units...');
        $this->call(UnitSeeder::class);

        // 3. Create super admin without unit
        $this->command->info('👑 Creating super admin...');
        $superAdmin = User::firstOrCreate(
            ['email' => 'admin@example.com'],
            [
                'nip' => '00000001',
                'name' => 'Super Admin',
                'password' => bcrypt('password'),
                'unit_id' => null,
            ]
        );
        if (!$superAdmin->hasRole('super_admin')) {
            $superAdmin->assignRole('super_admin');
        }
        $this->command->info('✅ Super admin created: admin@example.com');

        // 4. Create P2MPP staff
        $this->command->info('📋 Creating P2MPP staff...');
        $p2mppUnit = Unit::where('nama_unit', 'Kepala P2MPP')->first();
        if ($p2mppUnit) {
            $p2mpp = User::firstOrCreate(
                ['email' => 'p2mpp@example.com'],
                [
                    'nip' => '00000002',
                    'name' => 'Doddy Maulana, S.E., M.T.',
                    'password' => bcrypt('password'),
                    'unit_id' => $p2mppUnit->id,
                ]
            );
            if (!$p2mpp->hasRole('p2mpp')) {
                $p2mpp->assignRole('p2mpp');
            }
            $this->command->info('✅ P2MPP staff created: p2mpp@example.com (Doddy Maulana, S.E., M.T.)');
        }

        // 5. Create sample users for first 10 units (testing purposes)
        $this->command->info('👥 Creating sample users for testing...');
        $units = Unit::take(5)->get(); // Get first 5 units for testing
        
        foreach ($units as $index => $unit) {
            // Create a pimpinan for each unit
            $pimpinan = User::firstOrCreate(
                ['email' => 'pimpinan' . ($index + 1) . '@example.com'],
                [
                    'nip' => '1000' . str_pad($index + 1, 4, '0', STR_PAD_LEFT),
                    'name' => 'Pimpinan ' . $unit->nama_unit,
                    'password' => bcrypt('password'),
                    'unit_id' => $unit->id,
                ]
            );
            if (!$pimpinan->hasRole('pimpinan')) {
                $pimpinan->assignRole('pimpinan');
            }
        }

        // Create specific pimpinan for sample unit
        $this->command->info('👔 Creating specific pimpinan...');
        $samplePimpinan = User::firstOrCreate(
            ['email' => 'supriatna.pimpinan@example.com'],
            [
                'nip' => '10000100',
                'name' => 'Supriatna Adhisuwignjo, ST., MT',
                'password' => bcrypt('password'),
                'unit_id' => $units->first() ? $units->first()->id : null, // Assign to first unit or null
            ]
        );
        if (!$samplePimpinan->hasRole('pimpinan')) {
            $samplePimpinan->assignRole('pimpinan');
        }
        $this->command->info('✅ Pimpinan created: supriatna.pimpinan@example.com (Supriatna Adhisuwignjo, ST., MT)');

        // Create specific auditee for D3 Teknik Mesin Kampus Kediri
        $this->command->info('🎓 Creating specific auditee...');
        $targetUnit = Unit::where('nama_unit', 'D3 Teknik Mesin Kampus Kediri')->first();
        if ($targetUnit) {
            $auditee = User::firstOrCreate(
                ['email' => 'riswan.auditee@example.com'],
                [
                    'nip' => '00000100', // Menggunakan NIP yang unik
                    'name' => 'Riswan Eko Wahyu Susanto, S.Pd.,M.T',
                    'password' => bcrypt('password'),
                    'unit_id' => $targetUnit->id,
                ]
            );
            if (!$auditee->hasRole('auditee')) {
                $auditee->assignRole('auditee');
            }
            $this->command->info('✅ Auditee created: riswan.auditee@example.com for ' . $targetUnit->nama_unit);
        } else {
            $this->command->error('❌ Unit "D3 Teknik Mesin Kampus Kediri" not found!');
        }

        $this->command->info('✅ Sample users created for testing');

        // 6. Seed specific auditors (real data)
        $this->command->info('🔍 Seeding real auditor data...');
        $this->call(AuditorSeeder::class);

        // 7. Seed standards
        $this->command->info('📏 Seeding standards...');
        $this->call(StandarSeeder::class);

        $this->command->info('🎉 Database seeding completed successfully!');
        $this->command->info('');
        $this->command->info('📊 Default Login Credentials:');
        $this->command->info('Super Admin: admin@example.com / password');
        $this->command->info('P2MPP (Doddy Maulana): p2mpp@example.com / password');
        $this->command->info('Pimpinan (Supriatna): supriatna.pimpinan@example.com / password');
        $this->command->info('Auditee (Riswan): riswan.auditee@example.com / password');
        $this->command->info('All other users: password');
    }
}