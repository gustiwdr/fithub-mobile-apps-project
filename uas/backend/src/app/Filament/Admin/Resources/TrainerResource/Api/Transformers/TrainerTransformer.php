<?php

namespace App\Filament\Admin\Resources\TrainerResource\Api\Transformers;

use App\Models\Trainer;
use Illuminate\Http\Resources\Json\JsonResource;

/**
 * @property Trainer $resource
 */
class TrainerTransformer extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array
     */
    public function toArray($request)
    {
        return $this->resource->toArray();
    }
}
