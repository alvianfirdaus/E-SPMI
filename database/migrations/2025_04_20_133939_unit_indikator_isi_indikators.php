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
        Schema::create('unit_indikator_isi_indikators', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('unit_indikator_indikator_id');
            $table->foreign('unit_indikator_indikator_id', 'fk_uii_id')
                ->references('id')
                ->on('unit_indikator_indikators')
                ->onDelete('cascade');
            $table->foreignId('isi_indikator_id')->constrained()->onDelete('cascade');
            $table->text('pertanyaan');
            $table->string('target')->nullable();
            $table->text('bukti')->nullable();
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
        Schema::dropIfExists('unit_indikator_isi_indikators');
    }
};
