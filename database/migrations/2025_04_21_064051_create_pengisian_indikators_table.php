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
        Schema::create('pengisian_indikators', function (Blueprint $table) {
            $table->id();
            $table->foreignId('assign_pengisian_id')->constrained('assign_pengisians')->onDelete('cascade');
            $table->foreignId('ui_isi_indikator_id')->constrained('unit_indikator_isi_indikators')->onDelete('cascade');
            $table->enum('isi', ['tercapai', 'tidak_tercapai']);
            $table->text('bukti')->nullable();
            $table->text('faktor_penghambat')->nullable();
            $table->timestamp('answered_at')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('pengisian_indikators');
    }
};
