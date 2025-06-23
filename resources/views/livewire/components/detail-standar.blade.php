<div class="p-4">
    @if ($standar)
        <div class="space-y-2 prose max-w-none">
            <h3 class="text-lg font-bold text-primary-600">{{ $standar->nama_standar }}</h3>
            @if ($standar->subStandars->isEmpty())
                <p class="text-gray-500">Tidak ada Sub Standar</p>
            @else
                @foreach ($standar->subStandars as $sub)
                    <div class="ml-4 mb-4">
                        <p class="font-semibold text-gray-700">{{ $sub->nama_sub_standar }}</p>
                        @php
                            $isiStandars = $sub->isi_standars;
                        @endphp

                        @if ($isiStandars->isNotEmpty())
                            <table class="ml-6 mt-1 border border-gray-300 text-sm w-full max-w-3xl">
                                <thead>
                                    <tr class="bg-gray-100">
                                        <th class="border px-2 py-1 text-left">Nama Isi</th>
                                        <th class="border px-2 py-1 text-left">Deskripsi</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @foreach ($isiStandars as $isi)
                                        <tr>
                                            <td class="border px-2 py-1 align-top">{{ $isi->nama_isi }}</td>
                                            <td class="border px-2 py-1 align-top">
                                                {!! $isi->deskripsi !!}
                                            </td>
                                        </tr>
                                    @endforeach
                                </tbody>
                            </table>
                        @else
                            <p class="text-sm text-gray-500 ml-6">Tidak ada isi standar</p>
                        @endif
                    </div>
                @endforeach
            @endif
        </div>
    @else
        <p class="text-gray-500">Belum ada data standar yang dipilih.</p>
    @endif
</div>
