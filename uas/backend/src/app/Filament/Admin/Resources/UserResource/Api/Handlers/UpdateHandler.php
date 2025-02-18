<?php

namespace App\Filament\Admin\Resources\UserResource\Api\Handlers;

use App\Filament\Admin\Resources\UserResource;
use App\Filament\Admin\Resources\UserResource\Api\Requests\UpdateUserRequest;
use Rupadana\ApiService\Http\Handlers;

class UpdateHandler extends Handlers
{
    public static ?string $uri = '/{id}';

    public static ?string $resource = UserResource::class;

    public static function getMethod()
    {
        return Handlers::PUT;
    }

    public static function getModel()
    {
        return static::$resource::getModel();
    }

    /**
     * Update User
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function handler(UpdateUserRequest $request)
    {
        $id = $request->route('id');

        $model = static::getModel()::find($id);

        if (! $model) {
            return static::sendNotFoundResponse();
        }

        $model->fill($request->all());

        $model->save();

        return static::sendSuccessResponse($model, 'Successfully Update Resource');
    }
}
