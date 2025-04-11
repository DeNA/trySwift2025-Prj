//
//  File.metal
//  App
//
//  Created by Tsutomu Hayakawa on 2025/04/11.
//

#include <metal_stdlib>
using namespace metal;

[[ stitchable ]]
half4 rainbow(float2 position, half4 color, float2 size, float timeOffset) {
    float scaledX = position.x * (size.x / 300);
    float2 uv = float2(scaledX / size.x, position.y / size.y);
    float t = uv.x - timeOffset;
    
    half angle = t * 6.28318h;
    
    half3 rainbow = half3(
      sin(angle), sin(angle + 2.094h), sin(angle + 4.188h)
                          );
    
    return half4(rainbow + 0.5h + 0.5h, 1.0h) * color.a;
}
