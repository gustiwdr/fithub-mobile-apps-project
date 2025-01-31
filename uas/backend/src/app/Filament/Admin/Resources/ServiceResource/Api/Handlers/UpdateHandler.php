<?php

namespace App\Filament\Admin\Resources\ServiceResource\Api\Handlers;

use App\Filament\Admin\Resources\ServiceResource;
use App\Filament\Admin\Resources\ServiceResource\Api\Requests\UpdateServiceRequest;
use Rupadana\ApiService\Http\Handlers;

class UpdateHandler extends Handlers
{
    public static ?string $uri = '/{id}';

    public static ?string $resource = ServiceResource::class;

    public static function getMethod()
    {
        return Handlers::PUT;
    }

    public static function getModel()
    {
        return static::$resource::getModel();
    }

    /**
     * Update Service
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function handler(UpdateServiceRequest $request)
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
