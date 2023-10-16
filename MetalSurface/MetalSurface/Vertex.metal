//
//  Vertex.metal
//  MetalSurface
//

#include <metal_stdlib>
using namespace metal;

struct VertexIn {
    float4 position [[attribute(0)]];
};

struct Constants {
    float4x4 modelViewProjectionMatrix;
};

struct VertexOut {
    float4 position [[position]];
};

vertex VertexOut vertex_main(const VertexIn in [[stage_in]], constant Constants& constants [[buffer(0)]]) {
    VertexOut out;
    
    out.position = constants.modelViewProjectionMatrix * in.position;
    
    return out;
}
