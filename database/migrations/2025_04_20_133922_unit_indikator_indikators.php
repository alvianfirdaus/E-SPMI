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
        Schema::create('unit_indikator_indikators', function (Blueprint $table) {
            $table->id();
            $table->foreignId('unit_indikator_standar_id')->constrained()->onDelete('cascade');
            $table->foreignId('indikator_id')->constrained()->onDelete('cascade');
            $table->boolean('is_rejected')->default(false);
            $table->text('komentar')->nullable();
            $table->timestamps();
        });
        
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('unit_indikator_indikators');
    }
};
