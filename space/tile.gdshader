shader_type canvas_item;

uniform float topleft_radius : hint_range(0.0, 0.5) = 0.0;
uniform float topright_radius : hint_range(0.0, 0.5) = 0.0;
uniform float bottomleft_radius : hint_range(0.0, 0.5) = 0.0;
uniform float bottomright_radius : hint_range(0.0, 0.5) = 0.0;
vec2 scale(vec2 uv, float x, float y)
{
	mat2 scale = mat2(vec2(x, 0.0), vec2(0.0, y));
	
	uv -= 0.5;
	uv = uv * scale;
	uv += 0.5;
	return uv;
}

float circle(vec2 position, float radius, vec2 center)
{
	return 1.0 - step(radius, length(position - center));
}
// Pass UV for position
float rectangle(vec2 position, vec2 topleft, vec2 bottomright) {
	return float(
		position.x < bottomright.x && position.x > topleft.x &&
		position.y < bottomright.y && position.y > topleft.y);
}

void fragment() {
	
	float circle_corner_transparency = 
		circle(UV, topleft_radius, vec2(topleft_radius, topleft_radius)) +
		circle(UV, topright_radius, vec2(1.0 - topright_radius, topright_radius)) +
		circle(UV, bottomleft_radius, vec2(bottomleft_radius, 1.0 - bottomleft_radius)) + 
		circle(UV, bottomright_radius, vec2(1.0 - bottomright_radius, 1.0 - bottomright_radius));
	
	float rectangle_corner_transparency =
		rectangle(UV, vec2(0.0, topleft_radius), vec2(0.5, 1.0 - bottomleft_radius)) //left
		+ rectangle(UV, vec2(topleft_radius, 0.0), vec2(1.0 - topright_radius, 0.5)) // top
		+ rectangle(UV, vec2(0.5, topright_radius), vec2(1.0, 1.0 - bottomright_radius)) // right
		+ rectangle(UV, vec2(bottomleft_radius, 0.5), vec2(1.0 - bottomright_radius, 1.0)) // bottom
	;
	
	float transparency = clamp(circle_corner_transparency + rectangle_corner_transparency, 0.0, 1.0);
	//COLOR *= texture(TEXTURE, UV) * (transparency);
	COLOR.a *= transparency;
}