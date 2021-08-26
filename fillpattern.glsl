uniform Image pattern;
vec4 effect(vec4 color, Image texture, vec2 tcords, vec2 screen_coords)
{
 if (Texel(pattern, screen_coords /8).a==0) {
  return vec4(1,1,1,0);
 }
 return color;
}