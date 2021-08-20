/**
 SHADER : SIERPINKSI JULIA
 FORMULE :
 */


vec2 powc(vec2 z,float p) {
    vec2 polar = vec2(length(z),atan(z.y,z.x));
    
    polar.x = pow(polar.x,p);
    polar.y *= p;
    
    return vec2(polar.x * cos(polar.y),polar.x * sin(polar.y));
}



void main() {
    
#define iterations 128

    vec2 position = v_tex_coord; // gets the location of the current pixel in the intervals [0..1] [0..1]
    
    position.y = 1.0 - position.y;
    
    vec2 z = offset + position / zoom;
    
    
    
    // Rescale the position to the intervals [-2,1] [-1,1]
    z *= 2.0;
    z -= vec2(1.5,1.0);
    
    //aspect ratio
    float aspectRatio = u_sprite_size.x / u_sprite_size.y;
    //z.x *= aspectRatio;

    vec2 c = vec2(0.18,0.18);
    
    float it = 0.0; // Keep track of what iteration we reached
    for (int i = 0;i < iterations; ++i) {
        // zn = zn-1 ^ 2 + c
        
        // (x + yi) ^ 2 = x ^ 2 - y ^ 2 + 2xyi
        z = vec2(z.x * z.x - z.y * z.y, 2.0 * z.x * z.y);
        z += pow( 0.5 + c , powc(c,0.78));
        
        if (dot(z,z) > 4.0) { // dot(z,z) == length(z) ^ 2 only faster to compute
            break;
        }
        
        it += 1.0;
    }

    vec3 color = vec3(0.0,0.0,0.0); // initialize color to black
    
    if (it < float(iterations)) {
            color.x = tan(it / 3.0);                 // RED
        color.y = cos(it / 12.0 + 3.14 / 4.0);                 // GREEN
        color.z = cos(it / 6.0);   // BLUE
        }

    gl_FragColor = vec4(color,1.0);
}
