<?php

namespace App\Filament\Admin\Resources\TrainerResource\Api\Requests;

use Illuminate\Foundation\Http\FormRequest;

class UpdateTrainerRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            'company_id' => 'required|integer',
            'name' => 'required|string',
            'expertise' => 'required|string',
            'phone' => 'required|string',
            'email' => 'required|string',
            'profile_picture' => 'required|string',
        ];
    }
}
