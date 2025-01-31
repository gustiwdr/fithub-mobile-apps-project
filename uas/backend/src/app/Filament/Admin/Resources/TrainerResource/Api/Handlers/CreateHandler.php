<?php

namespace App\Filament\Admin\Resources\TrainerResource\Api\Handlers;

use App\Filament\Admin\Resources\TrainerResource;
use App\Filament\Admin\Resources\TrainerResource\Api\Requests\CreateTrainerRequest;
use Rupadana\ApiService\Http\Handlers;

class CreateHandler extends Handlers
{
    public static ?string $uri = '/';

    public static ?string $resource = TrainerResource::class;

    public static function getMethod()
    {
        return Handlers::POST;
    }

    public static function getModel()
    {
        return static::$resource::getModel();
    }

    /**
     * Create Trainer
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function handler(CreateTrainerRequest $request)
    {
        $model = new (static::getModel());

        $model->fill($request->all());

        $model->save();

        return static::sendSuccessResponse($model, 'Successfully Create Resource');
    }
}
