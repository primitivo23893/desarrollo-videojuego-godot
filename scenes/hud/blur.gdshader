shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_linear_mipmap;

const int samples = 32;
const int LOD = 2;          // gaussian done on MIPmap at scale LOD
const int sLOD = 1 << LOD;  // tile size = 2^LOD
const float sigma = float(samples) * 0.25;

float gaussian(vec2 i) {
    return exp(-0.5 * dot(i/sigma, i/sigma)) / (6.28 * sigma * sigma);
}

vec4 blur(sampler2D sp, vec2 uv, vec2 scale) {
    vec4 color = vec4(0.0);
    float total_weight = 0.0;
    int s = samples/sLOD;
    
    for (int i = 0; i < s*s; i++) {
        vec2 d = vec2(float(i%s), float(i/s)) * float(sLOD) - float(samples)/2.0;
        float weight = gaussian(d);
        color += textureLod(sp, uv + scale * d, float(LOD)) * weight;
        total_weight += weight;
    }
    
    // Normalize by total weight instead of alpha
    return color / total_weight;
}

void fragment() {
    vec2 uv = SCREEN_UV;
    vec2 texture_pixel_size = 1.0/vec2(textureSize(screen_texture, 0));
    
    COLOR = blur(screen_texture, uv, texture_pixel_size);
}
