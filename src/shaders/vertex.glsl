



uniform float uTime;
varying vec2 vUv;
varying float height;
varying float vDisplace;



float N21(vec2 p){
    return fract(sin(p.x * 100.0 + p.y * 7894.0) * 1234.0);
}

float Noise(vec2 uv){
    vec2 id = floor(uv);
    vec2 splitUV = fract(uv);
    splitUV = smoothstep(0.0, 1.0, splitUV);

    float bl = N21(id);
    float br = N21(id + vec2(1.0, 0.0));
    float tl = N21(id + vec2(0.0, 1.0));
    float tr = N21(id + vec2(1.0, 1.0));

    float b = mix(bl, br, splitUV.x);
    float t = mix(tl, tr, splitUV.x);

    float n = mix(b, t, splitUV.y);

    return n;
}


void main() {
    vec3 nPosition = position;

    vec2 aUv = uv;
    aUv -= uTime * 0.05;

    float height = Noise(aUv * 10.0);
    nPosition.z = height * 2.0;

    vDisplace = height;

    gl_Position = projectionMatrix * viewMatrix * modelMatrix * vec4(nPosition, 1.0);
    vUv = uv;
}