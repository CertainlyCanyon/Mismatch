shader_type canvas_item;

uniform float pixel_size = 250;
uniform float timer = 0;

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
		
	COLOR.rgb= c;
}
