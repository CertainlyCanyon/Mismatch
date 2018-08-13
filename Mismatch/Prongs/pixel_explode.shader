shader_type canvas_item;

uniform float pixel_size = 250;
uniform float timer = 0;
uniform float color_timer = 0;

vec3 hsv2rgb(vec3 c)
{
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}
void fragment() {
	vec2 uv = SCREEN_UV;
	if(int(uv.y*pixel_size)%2 == 1)
	{
		uv.x +=  (1.0-abs(cos(timer*1.0)));
	} else {
		uv.x -=  (1.0-abs(cos(timer*1.0)));
	}
	if(int(uv.x*pixel_size)%2 == 1)
	{
		uv.y +=  (1.0-abs(cos(timer*1.0)));
	} else {
		uv.y -=  (1.0-abs(cos(timer*1.0)));
	}
	
	
	
	vec3 c = textureLod(SCREEN_TEXTURE,uv,0.0).rgb;
	
	//vec3 mult_color = vec3((sin(TIME)+1.0)/2.0, 0, 0);//(sin(TIME*(6.283185307/3.0)+1.0)/2.0), (sin(TIME*(12.5663706144/3.0)+1.0)/2.0));
	vec3 mult_color = hsv2rgb(vec3((sin(color_timer)+1.0)/2.0, 1.0, 1.0));
	
	COLOR.rgb= c*mult_color;
}

