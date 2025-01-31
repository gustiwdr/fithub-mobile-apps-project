<?php

namespace App\Filament\Admin\Resources\TrainerResource\Api\Handlers;

use App\Filament\Admin\Resources\TrainerResource;
use App\Filament\Admin\Resources\TrainerResource\Api\Transformers\TrainerTransformer;
use Illuminate\Http\Request;
use Rupadana\ApiService\Http\Handlers;
use Spatie\QueryBuilder\QueryBuilder;

class PaginationHandler extends Handlers
{
    public static bool $public = true;

    public static ?string $uri = '/';

    public static ?string $resource = TrainerResource::class;

    /**
     * List of Trainer
     *
     * @param  Request  $request
     * @return \Illuminate\Http\Resources\Json\AnonymousResourceCollection
     */
    public function handler()
    {
        $query = static::getEloquentQuery();

        $query = QueryBuilder::for($query)
            ->allowedFields($this->getAllowedFields() ?? [])
            ->allowedSorts($this->getAllowedSorts() ?? [])
            ->allowedFilters($this->getAllowedFilters() ?? [])
            ->allowedIncludes($this->getAllowedIncludes() ?? [])
            ->paginate(request()->query('per_page'))
            ->appends(request()->query());

        return TrainerTransformer::collection($query);
    }
}
