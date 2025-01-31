<?php

namespace App\Filament\Admin\Resources\ServiceResource\Api\Handlers;

use App\Filament\Admin\Resources\ServiceResource;
use App\Filament\Admin\Resources\ServiceResource\Api\Requests\CreateServiceRequest;
use Rupadana\ApiService\Http\Handlers;

class CreateHandler extends Handlers
{
    public static ?string $uri = '/';

    public static ?string $resource = ServiceResource::class;

    public static function getMethod()
    {
        return Handlers::POST;
    }

    public static function getModel()
    {
        return static::$resource::getModel();
    }

    /**
     * Create Service
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function handler(CreateServiceRequest $request)
    {
        $model = new (static::getModel());

        $model->fill($request->all());

        $model->save();

        return static::sendSuccessResponse($model, 'Successfully Create Resource');
    }
}
