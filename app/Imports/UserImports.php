<?
namespace App\Imports;

use App\Models\Unit;
use App\Models\User;
use Spatie\Permission\Models\Role;
use Illuminate\Support\Facades\Hash;
use Maatwebsite\Excel\Concerns\ToModel;
use Maatwebsite\Excel\Concerns\WithHeadingRow;

class UsersImport implements ToModel, WithHeadingRow
{
    /**
     * Map the data from the file to the User model.
     *
     * @param array $row
     * @return \Illuminate\Database\Eloquent\Model|null
     */
    public function model(array $row)
    {
        $password = Hash::make($row['password']);
        $roleName = $row['role'] ?? 'user';
        $role = Role::whereRaw('LOWER(name) = ?', [strtolower($roleName)])->first();

        if (!$role) {
            return null;
        }

        $unitName = $row['unit_name']; // Assuming 'unit_name' column in the file
        $unit = Unit::whereRaw('LOWER(nama_unit) = ?', [strtolower($unitName)])->first();

        if (!$unit) {
            // Optionally, create the unit if it doesn't exist
            // $unit = Unit::create(['nama_unit' => $unitName]);
            return null; // Skip the row if the unit doesn't exist
        }

        // Create the user and assign the role
        $user = new User([
            'nip' => $row['nip'],
            'name' => $row['name'],
            'email' => $row['email'],
            'password' => $password,
        ]);

        // Save the user
        $user->save();

        // Assign the role to the user (using case-insensitive search for the role)
        $user->assignRole($roleName); // Assign the role by name

        // Assign the user to the unit
        $user->unit()->associate($unit); // Associate the unit to the user
        $user->save(); // Save after associating the unit

        return $user;
    }
}
