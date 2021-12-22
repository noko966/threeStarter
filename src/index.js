import './style.css';
import * as THREE from 'three';
import {
    OrbitControls
} from 'three/examples/jsm/controls/OrbitControls'

import vertex from './shaders/vertex2.glsl';
import fragment from './shaders/fragment2.glsl';

import gsap from 'gsap';


function main() {
    const canvas = document.querySelector('#canvas');
    const renderer = new THREE.WebGLRenderer({
        canvas,
        alpha: true,
        antialias: true,
    });
    renderer.setClearColor(0x000000, 0.0);

    const fov = 45;
    const aspect = 2; // the canvas default
    const near = 0.1;
    const far = 1000;
    // const camera = new THREE.PerspectiveCamera(fov, aspect, near, far);
    const camera = new THREE.PerspectiveCamera(fov, aspect, near, far);

    camera.position.z = 40;


    const sceneBg = 0x0a0a0a;
    const scene = new THREE.Scene();
    scene.background = null;

    const planeSize = 10;
    const planeSegs = 100;
    const planeGeometry = new THREE.PlaneGeometry(planeSize, planeSize, planeSegs, planeSegs);

    const boxWidth = 10;
    const boxHeight = 10;
    const boxDepth = 10;
    const boxSegs = 5;

    const boxGeometry = new THREE.BoxGeometry(boxWidth, boxHeight, boxDepth, boxSegs, boxSegs, boxSegs);

    const axis = new THREE.AxesHelper(10);
    // scene.add(axis);
    
    const uniforms = {
        uTime: { value: 0 },
    }

    const planeMaterial = new THREE.ShaderMaterial({
        wireframe: false,
        transparent: true,
        side: THREE.DoubleSide,
        uniforms,
        vertexShader: vertex,
        fragmentShader: fragment
    })

    // const plane = new THREE.Mesh(planeGeometry, planeMaterial);
    // const box = new THREE.Mesh(boxGeometry, planeMaterial);

    const box = new THREE.Points(boxGeometry, planeMaterial);

    scene.add(box);

    const color = 0xFFFFFF;
    const intensity = 1;
    const light = new THREE.DirectionalLight(color, intensity);
    light.position.set(-1, 2, 4);
    scene.add(light);

    renderer.render(scene, camera);

    function resizeRendererToDisplaySize(renderer) {
        const canvas = renderer.domElement;
        const pixelRatio = window.devicePixelRatio;
        const width = canvas.clientWidth * pixelRatio | 0;
        const height = canvas.clientHeight * pixelRatio | 0;
        const needResize = canvas.width !== width || canvas.height !== height;
        if (needResize) {
            renderer.setSize(width, height, false);
        }
        return needResize;
    }

    const controls = new OrbitControls( camera, renderer.domElement );

    var tl = gsap.timeline();

    const obj = {x: 0, y: 0, z: 0};

    tl.to(obj, {
        duration: 1,
        x: 6,
        y: 6,
        z: 6,
        onUpdate: ()=>{
            box.position.set(obj.x,obj.y,obj.z);
        }
    });

    tl.to(obj, {
        duration: 1,
        x: 0,
        y: 0,
        z: 0,
        onUpdate: ()=>{
            box.position.set(obj.x,obj.y,obj.z);
        }
    });

    function render(time) {
        time *= 0.001;

        box.material.uniforms.uTime.value = time;

        // plane.rotation.y = time;

        if (resizeRendererToDisplaySize(renderer)) {
            const canvas = renderer.domElement;
            camera.aspect = canvas.clientWidth / canvas.clientHeight;
            camera.updateProjectionMatrix();
        }

        controls.update();

        renderer.render(scene, camera);

        requestAnimationFrame(render);
    }
    requestAnimationFrame(render);
}

main();