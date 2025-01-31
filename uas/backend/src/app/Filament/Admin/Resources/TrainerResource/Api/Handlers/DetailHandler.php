<?php

namespace App\Filament\Admin\Resources\TrainerResource\Api\Handlers;

use App\Filament\Admin\Resources\TrainerResource;
use App\Filament\Admin\Resources\TrainerResource\Api\Transformers\TrainerTransformer;
use Illuminate\Http\Request;
use Rupadana\ApiService\Http\Handlers;
use Spatie\QueryBuilder\QueryBuilder;

class DetailHandler extends Handlers
{
    public static ?string $uri = '/{id}';

    public static ?string $resource = TrainerResource::class;

    /**
     * Show Trainer
     *
     * @return TrainerTransformer
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

        return new TrainerTransformer($query);
    }
}
