<?php

namespace Database\Factories;

use App\Models\Standar;
use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Standar>
 */
class StandarFactory extends Factory
{
    protected $model = Standar::class;

    public function definition(): array
    {
        return [
            'kode_standar' => 'STD-' . $this->faker->unique()->regexify('[0-9]{3}'),
            'nama_standar' => 'Standar ' . $this->faker->words(3, true),
            'tahun' => $this->faker->numberBetween(2020, date('Y')),
            'status' => $this->faker->randomElement(['pending', 'validated']),
            'validated_by' => null,
            'validated_time' => $this->faker->optional(0.7)->dateTimeBetween('-1 year', 'now'),
            'created_by' => null,
        ];
    }

    public function validated(): static
    {
        return $this->state(fn (array $attributes) => [
            'status' => 'validated',
            'validated_time' => $this->faker->dateTimeBetween('-1 year', 'now'),
        ]);
    }

    public function pending(): static
    {
        return $this->state(fn (array $attributes) => [
            'status' => 'pending',
            'validated_time' => null,
            'validated_by' => null,
        ]);
    }

    public function forYear(int $year): static
    {
        return $this->state(fn (array $attributes) => [
            'tahun' => $year,
        ]);
    }
}