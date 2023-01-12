class_name ColorLabel
extends Label

func is_instruction() -> bool:
	return true
	
func _update(color : Color):
	layout_mode = 0
	size = Vector2(0,Config.TEXT_BOX_HEIGHT/2)
	horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	add_theme_color_override("font_color", color)
	add_theme_color_override("font_outline_color", Color.BLACK)
	add_theme_constant_override("outline_size", 5)
	add_theme_font_size_override("font_size", 14)
