<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('jadwal', function (Blueprint $table) {
            $table->id();
            $table->foreignId('periode_id')->constrained('periodes')->onDelete('cascade');
            $table->string('judul');
            $table->text('deskripsi')->nullable();

            $table->date('start_date');
            $table->time('start_time')->nullable();
            $table->date('end_date');
            $table->time('end_time')->nullable();

            $table->boolean('is_all_day')->default(false);
            $table->boolean('is_active')->default(true);
            $table->enum('type', ['rapat', 'audit', 'pelatihan', 'lainnya'])->default('lainnya');
            $table->enum('priority', ['rendah', 'sedang', 'tinggi', 'mendesak'])->default('sedang');

            $table->string('location')->nullable();
            $table->string('meeting_link')->nullable();

            $table->enum('status', ['pending', 'validated', 'rejected'])->default('pending');

            $table->foreignId('validated_by')->nullable()->constrained('users')->onDelete('set null');
            $table->timestamp('validated_time')->nullable();
            $table->foreignId('created_by')->nullable()->constrained('users')->onDelete('set null');
            $table->timestamps();

            $table->index(['start_date', 'end_date']);
            $table->index(['periode_id', 'status']);
        });
        Schema::create('jadwal_assignments', function (Blueprint $table) {
            $table->id();
            $table->foreignId('jadwal_id')->constrained('jadwal')->onDelete('cascade');
            $table->foreignId('user_id')->constrained('users')->onDelete('cascade');
            $table->enum('role_user', ['organizer', 'attendee', 'auditor', 'auditee', 'pimpinan', 'p2mpp', 'optional'])->default('attendee');
            $table->timestamps();

            $table->unique(['jadwal_id', 'user_id']);
        });
        Schema::create('jadwal_units', function (Blueprint $table) {
            $table->id();
            $table->foreignId('jadwal_id')->constrained('jadwal')->onDelete('cascade');
            $table->foreignId('unit_id')->constrained('units')->onDelete('cascade');
            $table->timestamps();

            $table->unique(['jadwal_id', 'unit_id']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('jadwal_units');
        Schema::dropIfExists('jadwal_assignments');
        Schema::dropIfExists('jadwal');
    }
};
