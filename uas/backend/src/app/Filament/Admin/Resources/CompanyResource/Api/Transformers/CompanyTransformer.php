<?php

namespace App\Filament\Admin\Resources\CompanyResource\Api\Transformers;

use App\Models\Company;
use Illuminate\Http\Resources\Json\JsonResource;

/**
 * @property Company $resource
 */
class CompanyTransformer extends JsonResource
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
