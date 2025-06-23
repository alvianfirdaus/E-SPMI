@php
    $days = [
        'Monday'    => 'Senin',
        'Tuesday'   => 'Selasa',
        'Wednesday' => 'Rabu',
        'Thursday'  => 'Kamis',
        'Friday'    => 'Jumat',
        'Saturday'  => 'Sabtu',
        'Sunday'    => 'Minggu',
    ];

    $months = [
        'Jan' => 'Jan',
        'Feb' => 'Feb',
        'Mar' => 'Mar',
        'Apr' => 'Apr',
        'May' => 'Mei',
        'Jun' => 'Jun',
        'Jul' => 'Jul',
        'Aug' => 'Agu',
        'Sep' => 'Sep',
        'Oct' => 'Okt',
        'Nov' => 'Nov',
        'Dec' => 'Des',
    ];

    $now = now()->setTimezone('Asia/Jakarta');
    $dayIndo = $days[$now->format('l')] ?? $now->format('l');
    $monthIndo = $months[$now->format('M')] ?? $now->format('M');
@endphp

<div wire:poll.1000ms class="text-sm">
    {{ $dayIndo }}, {{ $now->format('d') }} {{ $monthIndo }} {{ $now->format('Y') }} | {{ $now->format('H:i:s') }}
</div>
