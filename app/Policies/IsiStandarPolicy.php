<?php

namespace App\Policies;

use App\Models\User;
use App\Models\IsiStandar;
use Illuminate\Auth\Access\HandlesAuthorization;

class IsiStandarPolicy
{
    use HandlesAuthorization;

    /**
     * Determine whether the user can view any models.
     */
    public function viewAny(User $user): bool
    {
        return $user->can('view_any_isi::standar');
    }

    /**
     * Determine whether the user can view the model.
     */
    public function view(User $user, IsiStandar $isiStandar): bool
    {
        return $user->can('view_isi::standar');
    }

    /**
     * Determine whether the user can create models.
     */
    public function create(User $user): bool
    {
        return $user->can('create_isi::standar');
    }

    /**
     * Determine whether the user can update the model.
     */
    public function update(User $user, IsiStandar $isiStandar): bool
    {
        return $user->can('update_isi::standar');
    }

    /**
     * Determine whether the user can delete the model.
     */
    public function delete(User $user, IsiStandar $isiStandar): bool
    {
        return $user->can('delete_isi::standar');
    }

    /**
     * Determine whether the user can bulk delete.
     */
    public function deleteAny(User $user): bool
    {
        return $user->can('delete_any_isi::standar');
    }

    /**
     * Determine whether the user can permanently delete.
     */
    public function forceDelete(User $user, IsiStandar $isiStandar): bool
    {
        return $user->can('force_delete_isi::standar');
    }

    /**
     * Determine whether the user can permanently bulk delete.
     */
    public function forceDeleteAny(User $user): bool
    {
        return $user->can('force_delete_any_isi::standar');
    }

    /**
     * Determine whether the user can restore.
     */
    public function restore(User $user, IsiStandar $isiStandar): bool
    {
        return $user->can('restore_isi::standar');
    }

    /**
     * Determine whether the user can bulk restore.
     */
    public function restoreAny(User $user): bool
    {
        return $user->can('restore_any_isi::standar');
    }

    /**
     * Determine whether the user can replicate.
     */
    public function replicate(User $user, IsiStandar $isiStandar): bool
    {
        return $user->can('replicate_isi::standar');
    }

    /**
     * Determine whether the user can reorder.
     */
    public function reorder(User $user): bool
    {
        return $user->can('reorder_isi::standar');
    }
}
