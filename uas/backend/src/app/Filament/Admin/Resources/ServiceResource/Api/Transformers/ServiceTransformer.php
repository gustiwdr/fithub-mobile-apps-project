<?php

namespace App\Filament\Admin\Resources\ServiceResource\Api\Transformers;

use App\Models\Service;
use Illuminate\Http\Resources\Json\JsonResource;

/**
 * @property Service $resource
 */
class ServiceTransformer extends JsonResource
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
