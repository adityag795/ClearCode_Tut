shader_type canvas_item;

uniform vec3 color: source_color = vec3(1);
uniform float progress: hint_range(0.0, 1.0, 0.1) = 0;

void fragment() {
	// float test_var = 0.1;
	// UV gives position of the current pixel
	float current_a = texture(TEXTURE, UV).a;
//	if (current_a == 1.0)
//	{
//		COLOR = vec4(1,1,1,1); // Red, Green, Blue, Alpha
//	}
// Avoid if statements with shading language because they have 
// some performance penalties
// mix() is used to mix two colors. How much of 2nd color you get is detemined by 3rd parameter value.
	vec4 target_color = mix(texture(TEXTURE, UV), vec4(color, current_a), progress);
	COLOR = target_color;
}
