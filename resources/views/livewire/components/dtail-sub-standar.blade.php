<div class="p-4">
    @if ($indikator)
        <div class="space-y-2">
            <div class="mb-4">
                <h3 class="text-lg font-bold text-primary-600">Detail Indikator</h3>
                <div class="grid grid-cols-2 gap-4 mt-2">
                    <div>
                        <strong>Standar:</strong>
                        <p>{{ $indikator->subStandar->standar->nama_standar ?? 'Tidak diketahui' }}</p>
                    </div>
                    <div>
                        <strong>Sub Standar:</strong>
                        <p>{{ $indikator->subStandar->nama_sub_standar ?? 'Tidak diketahui' }}</p>
                    </div>
                </div>
            </div>
            @if ($indikator->isiIndikators->isNotEmpty())
                <div>
                    <strong>Isi Indikator:</strong>
                    <div class="overflow-x-auto">
                        <table class="w-full border">
                            <thead>
                                <tr>
                                    <th class="border text-sm w-12 ">No</th>
                                    <th class="border text-sm text-center">Indikator</th>
                                    <th class="border text-sm text-center">Pertanyaan</th>
                                    <th class="border text-sm text-center">Target</th>
                                    <th class="border text-sm text-center">Bukti</th>
                                </tr>
                            </thead>
                            <tbody>
                                @foreach ($indikator->isiIndikators as $index => $isiIndikator)
                                    @php
                                        $unitData = null;
                                        if (isset($unitIndikatorIndikator)) {
                                            $unitData = \App\Models\UnitIndikatorIsiIndikator::where(
                                                'unit_indikator_indikator_id',
                                                $unitIndikatorIndikator->id,
                                            )
                                                ->where('isi_indikator_id', $isiIndikator->id)
                                                ->first();
                                        }
                                    @endphp
                                    <tr>
                                        <td class="border px-2 py-1 text-center text-sm">{{ $index + 1 }}</td>
                                        <td class="border px-2 py-1 text-sm">
                                            {!! $isiIndikator->isi_indikator ?? 'Tidak ada detail' !!}
                                        </td>
                                        <td class="border px-2 py-1">
                                            @if ($unitData && $unitData->pertanyaan)
                                                <div class="max-w-sm">
                                                    <span class="text-sm">
                                                        {{ $unitData->pertanyaan }}
                                                    </span>

                                                </div>
                                            @else
                                                <span class="text-sm italic">Belum ada data</span>
                                            @endif
                                        </td>
                                        <td class="border px-2 py-1">
                                            @if ($unitData && $unitData->target)
                                                <span class="text-sm">
                                                    {{ $unitData->target }}
                                                </span>
                                            @else
                                                <span class="text-sm italic">Belum ada data</span>
                                            @endif
                                        </td>
                                        <td class="border px-2 py-1">
                                            @if ($unitData && $unitData->bukti)
                                                <span
                                                    class="inline-flex items-center px-2 py-1 rounded-md text-sm font-medium bg-green-100 text-green-800 dark:bg-green-900 dark:text-green-200">
                                                    {{ $unitData->bukti }}
                                                </span>
                                            @else
                                                <span class="text-sm italic">Belum ada data</span>
                                            @endif
                                        </td>
                                    </tr>
                                @endforeach
                            </tbody>
                        </table>
                    </div>
                </div>
            @else
                <p class="text-gray-500 dark:text-gray-400">Tidak ada isi indikator.</p>
            @endif
        </div>
    @else
        <p class="text-gray-500 dark:text-gray-400">Indikator tidak ditemukan.</p>
    @endif
</div>
