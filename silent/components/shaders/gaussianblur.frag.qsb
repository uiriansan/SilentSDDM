#version 440

layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 fragColor;

layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;
    vec2 pixelStep;
    int radius;
    float deviation;
};
layout(binding = 1) uniform sampler2D src;

#define PI 3.1415926538

float gaussianWeight(vec2 coords)
{
    float x2 = pow(coords.x, 2.0);
    float y2 = pow(coords.y, 2.0);
    float deviation2 = pow(deviation, 2.0);

    return (1.0 / (2.0 * PI * deviation2)) * exp(-(x2 + y2) / (2.0 * deviation2));
}

void main(void)
{
    vec3 sum = vec3(0.0, 0.0, 0.0);
    float gaussianSum = 0.0;
    for (int x = -radius; x <= radius; ++x) {
        for (int y = -radius; y <= radius; ++y) {
            vec2 c = qt_TexCoord0 + vec2(x, y) * pixelStep;
            float w = gaussianWeight(vec2(x, y));
            sum += texture(src, c).rgb * w;
            gaussianSum += w;
        }
    }

    fragColor = vec4(sum / gaussianSum, 1.0) * qt_Opacity;
}
