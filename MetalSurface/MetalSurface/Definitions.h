//
//  Definitions.h
//  MetalSurface
//
//  Created by MacBookAir on 10.10.2023.
//

#ifndef Definitions_h
#define Definitions_h
#include <simd/simd.h>

struct LightingParams {
  vector_float3 lightDirection;
  vector_float4 newColor;
};

#endif /* Definitions_h */
