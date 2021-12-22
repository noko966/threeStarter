
uniform float uTime;
varying vec2 vUv;
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




void main()
{





    

    float n = Noise(vUv * 2.0);
    n += Noise(vUv * 4.0) * 0.5;
    n += Noise(vUv * 8.0) * 0.25;
    n += Noise(vUv * 16.0) * 0.125;
    n += Noise(vUv * 32.0) * 0.0625;

    n/= 2.0;
    
    vec3 color = vec3(step(0.2, fract(vDisplace * 10.0)));

    vec3 red = vec3(1.0, 0.0, 0.0);
    vec3 black = vec3(0.0, 0.0, 0.0);


    color = mix(red, black, color);
    color = mix(black, color, vDisplace);
    color = mix(vec3(N21(color.xy)) * 0.2, color, vDisplace);

    // vec3 color = vec3(vDisplace);

    
    gl_FragColor = vec4(color, 1.0);





}






