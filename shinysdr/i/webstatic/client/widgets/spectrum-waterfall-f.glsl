// Copyright 2013, 2014, 2015, 2016 Kevin Reid and the ShinySDR contributors
// 
// This file is part of ShinySDR.
// 
// ShinySDR is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// ShinySDR is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
// 
// You should have received a copy of the GNU General Public License
// along with ShinySDR.  If not, see <http://www.gnu.org/licenses/>.

uniform sampler2D data;
uniform sampler2D gradient;
uniform mediump float gradientZero;
uniform mediump float gradientScale;
varying mediump vec2 v_position;
uniform highp float textureRotation;

void main(void) {
  highp vec2 texLookup = mod(v_position, 1.0);
  highp float freqOffset = getFreqOffset(texLookup) * freqScale;
  mediump vec2 shift = texLookup + vec2(freqOffset, 0.0);
  if (shift.x < 0.0 || shift.x > 1.0) {
    gl_FragColor = BACKGROUND_COLOR;
  } else {
    mediump float data = texture2D(data, shift + vec2(textureRotation, 0.0)).r;
    gl_FragColor = texture2D(gradient, vec2(0.5, gradientZero + gradientScale * data));
//    gl_FragColor = texture2D(gradient, vec2(0.5, v_position.x));
//    gl_FragColor = vec4(gradientZero + gradientScale * data * 4.0 - 0.5);
  }
}
