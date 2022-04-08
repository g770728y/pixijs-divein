precision highp float;
attribute vec2 aVertexPosition;
attribute vec2 aTextureCoord;
attribute vec2 aNormalOffset;
attribute vec4 aColor;
attribute float aTextureId;

uniform mat3 projectionMatrix;
uniform mat3 translationMatrix;
uniform vec4 tint;
uniform float scale;

varying vec2 vTextureCoord;
varying vec4 vColor;
varying float vTextureId;

void main(void) {
    vec3 offset = vec3(aNormalOffset * (scale - 1.0) / scale, 0.0);
    gl_Position = vec4((projectionMatrix * (translationMatrix * (vec3(aVertexPosition, 1.0) + offset))).xy, 0.0, 1.0);

    vTextureCoord = aTextureCoord;
    vTextureId = aTextureId;
    vColor = aColor * tint;
}
