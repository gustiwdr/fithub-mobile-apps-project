<?php

namespace App\Filament\Admin\Resources\ServiceResource\Api;

use App\Filament\Admin\Resources\ServiceResource;
use Rupadana\ApiService\ApiService;

class ServiceApiService extends ApiService
{
    protected static ?string $resource = ServiceResource::class;

    public static function handlers(): array
    {
        return [
            Handlers\CreateHandler::class,
            Handlers\UpdateHandler::class,
            Handlers\DeleteHandler::class,
            Handlers\PaginationHandler::class,
            Handlers\DetailHandler::class,
        ];

    }
}
