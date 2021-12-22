uniform float uTime;
varying vec2 vUv;
varying float height;
varying float vDisplace;

void main() {
    vec4 mvPosition = viewMatrix * modelMatrix * vec4(position, 1.0);
    gl_PointSize = 300.0 * (1.0 / - mvPosition.z);
    gl_Position = projectionMatrix * mvPosition;
    vUv = uv;
}


