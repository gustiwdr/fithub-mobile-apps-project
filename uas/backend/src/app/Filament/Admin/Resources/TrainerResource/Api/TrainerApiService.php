<?php

namespace App\Filament\Admin\Resources\TrainerResource\Api;

use App\Filament\Admin\Resources\TrainerResource;
use Rupadana\ApiService\ApiService;

class TrainerApiService extends ApiService
{
    protected static ?string $resource = TrainerResource::class;

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
