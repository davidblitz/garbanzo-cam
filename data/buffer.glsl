#define PROCESSING_TEXTURE_SHADER

uniform sampler2D iChannel0;
uniform sampler2D iChannel1;
uniform vec2 iResolution;
uniform float iTime;

varying vec4 vertTexCoord;
//out vec4 fragColor;
void main(){
    vec2 uv = vec2(vertTexCoord.s, 1.0 - vertTexCoord.t);// / iResolution.xy;    
    vec3 c = texture(iChannel0, uv).rgb;

    float d = 0.001 / c.g;
    float a = c.r * 15.0 + c.b * 10.0 + sin(iTime*0.001);
    uv.x += d * cos(a);
    uv.y += d * sin(a);

    c = texture(iChannel1, uv).rgb * 0.95  // buffer
      + texture(iChannel0, uv).rbg * 0.05; // webcam
    
    c.r = pow(mod(c.r * 1.003 , 1.0), 1.003);
    c.g = pow(mod(c.g * 1.004 , 1.0), 1.004);
    c.b = pow(mod(c.b * 1.005 , 1.0), 1.005);
        
        
    gl_FragColor = vec4(c, 1.0);
}
