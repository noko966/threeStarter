
uniform float uTime;
varying vec2 vUv;
varying float vDisplace;

float plot(vec2 st, float pct){
  return  smoothstep( pct-0.02, pct, st.y) -
          smoothstep( pct, pct+0.02, st.y);
}


void main()
{   

    vec2 UV = vUv - vec2(0.5);

    float y = UV.x;
    vec3 color = vec3(y);

    // vec3 red = vec3(1.0, 0.0, 0.0);
    float pct = plot(UV, y);
    // vec3 color = plot(vUv) * red;

    // float a = 1.0 - pow(abs(vUv.x - 0.5), 1.5);
    vec3 c = vec3(1.0);

    gl_FragColor = vec4(c, 1.0);
}






