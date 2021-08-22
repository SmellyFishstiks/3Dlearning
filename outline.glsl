uniform vec4 col;
uniform float thicness;
uniform vec2 scale;

vec4 effect(vec4 color, Image texture, vec2 tcords, vec2 screen_coords)
{
 vec4 pixel = Texel(texture, tcords );
 vec4 a = Texel(texture, vec2(tcords.x + scale.x*thicness,tcords.y                 ) );
 vec4 b = Texel(texture, vec2(tcords.x                   ,tcords.y+scale.y*thicness) );
 vec4 c = Texel(texture, vec2(tcords.x - scale.x*thicness,tcords.y                 ) );
 vec4 d = Texel(texture, vec2(tcords.x                   ,tcords.y-scale.y*thicness) );
 
 
 
 float v = pixel.a + a.a +b.a +c.a +d.a;
 if ( v < 5 && v!=0 )
 {
  return col;
 }
 else
 {
  return pixel;
 }
 
}