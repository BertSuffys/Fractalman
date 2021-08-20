/**
 SHADER : BURNING SHIP
 FORMULE :
 */

void main() {
    
#define iterations 256

    vec2 position = v_tex_coord; // gets the location of the current pixel in the intervals [0..1] [0..1]
    
    // invert the y position
    position.y = 1.0 - position.y;
    
    


    
    //vec2 z = position; // z.x is the real component z.y is the imaginary component
    vec2 z = offset + ( position / zoom );
    //vec2 z = 0 + ( position / 1.0 );
    //vec2 z = position;
    
    
    
    // Rescale the position to the intervals [-2,1] [-1,1]
    z *= vec2(6.0,4.0);
    z -= vec2(3.5,2.5);
    
    //aspect ratio
    float aspectRatio = u_sprite_size.x / u_sprite_size.y;
    //z.x *= aspectRatio;

    vec2 c = z;

    float it = 0.0; // Keep track of what iteration we reached
    for (int i = 0;i < iterations; ++i) {
        // zn = zn-1 ^ 2 + c

        // (x + yi) ^ 2 = x ^ 2 - y ^ 2 + 2xyi
        z = vec2(z.x * z.x - z.y * z.y, 2.0 * z.x * z.y);
        z += c;
        z = abs(z);

        // Number keeps growing > Not in mandelbrot set > Color
        if (dot(z,z) > 4.0) { // dot(z,z) == length(z) ^ 2 only faster to compute
            break;
        }

        it += 1.0;
    }

    vec3 color = vec3(0.0,0.0,0.0); // initialize color to black
    
    if (it < float(iterations)) {
            color.x = sin(it / 3.0);                 // RED
            color.y = cos(it / 6.0);                 // GREEN
            color.z = cos(it / 12.0 + 3.14 / 4.0);   // BLUE
        }

    gl_FragColor = vec4(color,1.0);
}
