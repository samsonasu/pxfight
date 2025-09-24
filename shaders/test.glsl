// shader.glsl
extern vec4 color;

void main() {
    vec4 texColor = Texel(texture, TexCoord);
    gl_FragColor = texColor * color;
}
