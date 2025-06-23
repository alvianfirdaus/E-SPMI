<div class="p-4 space-y-2">
    <h4 class="font-semibold text-lg">Users in this Unit</h4>
    <ul class="list-disc pl-5">
        @forelse ($users as $user)
            <li>{{ $user->name }} ({{ $user->email }})</li>
        @empty
            <li>No users assigned.</li>
        @endforelse
    </ul>
</div>
