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
        Schema::create('unit_indikators', function (Blueprint $table) {
            $table->id();
            $table->foreignId('unit_id')->constrained()->onDelete('cascade');
            $table->enum('status', ['pending', 'validated'])->default('pending');
            $table->foreignId('auditee')->nullable()->constrained('users');
            $table->foreignId('validator_1_id')->nullable()->constrained('users');
            $table->enum('status_validasi_1', ['pending', 'validated', 'rejected'])->default('pending');
            $table->timestamp('validated_time_1')->nullable();
            $table->text('komentar_validasi_1')->nullable();
            $table->foreignId('created_by')->nullable()->constrained('users')->onDelete('set null');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('unit_indikators');
    }
};
