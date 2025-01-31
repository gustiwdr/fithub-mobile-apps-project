<?php

namespace App\Filament\Admin\Resources\TrainerResource\Api\Handlers;

use App\Filament\Admin\Resources\TrainerResource;
use App\Filament\Admin\Resources\TrainerResource\Api\Requests\UpdateTrainerRequest;
use Rupadana\ApiService\Http\Handlers;

class UpdateHandler extends Handlers
{
    public static ?string $uri = '/{id}';

    public static ?string $resource = TrainerResource::class;

    public static function getMethod()
    {
        return Handlers::PUT;
    }

    public static function getModel()
    {
        return static::$resource::getModel();
    }

    /**
     * Update Trainer
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function handler(UpdateTrainerRequest $request)
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
