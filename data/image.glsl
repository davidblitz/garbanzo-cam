#define PROCESSING_TEXTURE_SHADER

uniform sampler2D iChannel0;

varying vec4 vertTexCoord;

void main() {  
    vec2 uv = vec2(vertTexCoord.s, 1.0 - vertTexCoord.t);
    vec4 c = texture(iChannel0, uv);
    vec4 c2 = texture(iChannel0, uv + vec2(0.002, 0.002));
    c = c - 0.05*distance(c, c2);
    
    gl_FragColor = vec4(c.rgb, 1.0);
}
