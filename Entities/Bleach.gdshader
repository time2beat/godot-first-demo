shader_type canvas_item;

uniform bool active = false;

void fragment() {
	vec4 previous_pixel = texture(TEXTURE, UV);
	vec4 bleached_pixel = vec4(1.0, 1.0, 1.0, previous_pixel.a);
	COLOR = active ? bleached_pixel : previous_pixel;
}
