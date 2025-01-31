<?php

namespace App\Filament\Admin\Resources\ServiceResource\Api\Handlers;

use App\Filament\Admin\Resources\ServiceResource;
use App\Filament\Admin\Resources\ServiceResource\Api\Transformers\ServiceTransformer;
use Illuminate\Http\Request;
use Rupadana\ApiService\Http\Handlers;
use Spatie\QueryBuilder\QueryBuilder;

class DetailHandler extends Handlers
{
    public static ?string $uri = '/{id}';

    public static ?string $resource = ServiceResource::class;

    /**
     * Show Service
     *
     * @return ServiceTransformer
     */
    public function handler(Request $request)
    {
        $id = $request->route('id');

        $query = static::getEloquentQuery();

        $query = QueryBuilder::for(
            $query->where(static::getKeyName(), $id)
        )
            ->first();

        if (! $query) {
            return static::sendNotFoundResponse();
        }

        return new ServiceTransformer($query);
    }
}
