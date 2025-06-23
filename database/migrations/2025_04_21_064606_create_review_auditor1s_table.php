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
        Schema::create('review_auditor1s', function (Blueprint $table) {
            $table->id();
            $table->foreignId('pengisian_indikators_id')->constrained('pengisian_indikators')->onDelete('cascade');
            $table->enum('status_temuan', ['sesuai', 'tidak_sesuai'])->nullable();
            $table->text('hasil_pengamatan')->nullable();
            $table->enum('status', ['pending', 'reviewed'])->default('pending');
            $table->timestamp('reviewed_at')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('review_auditor1s');
    }
};