// https://blogs.love2d.org/content/let-it-glow-dynamically-adding-outlines-characters

vec4 resultCol;
vec4 textureCol;

vec4 effect( vec4 col, Image texture, vec2 texturePos, vec2 screenPos )
{
    number stepSize = 0.03f;
    number alpha = 4*texture2D( texture, texturePos ).a;
    alpha -= texture2D( texture, texturePos + vec2( stepSize, 0.0f ) ).a;
    alpha -= texture2D( texture, texturePos + vec2( -stepSize, 0.0f ) ).a;
    alpha -= texture2D( texture, texturePos + vec2( 0.0f, stepSize ) ).a;
    alpha -= texture2D( texture, texturePos + vec2( 0.0f, -stepSize ) ).a;

    // calculate resulting color
    resultCol = vec4( 1.0f, 1.0f, 1.0f, alpha );
    // return color for current pixel
    return resultCol;
}


