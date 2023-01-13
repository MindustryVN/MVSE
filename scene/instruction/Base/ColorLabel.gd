class_name ColorLabel
extends Label

var update_before : bool = true

func _ready() -> void:
	Config.on_content_change.connect(resize.bind())

func is_update_before() -> bool:
	return update_before

func set_update_before(value : bool) -> ColorLabel:
	update_before = value
	return self

func is_instruction() -> bool:
	return true

func update(color : Color):
	layout_mode = 0
	size = Vector2(text.length() * Config.COMPONENT_SPACE_X + 50, Config.TEXT_BOX_HEIGHT/2)
	horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	add_theme_color_override("font_color", color)
	add_theme_color_override("font_outline_color", Color.BLACK)
	add_theme_constant_override("outline_size", 5)
	add_theme_font_size_override("font_size", 14)
	resize()
	

func resize() -> void:
	match vertical_alignment:
		VERTICAL_ALIGNMENT_BOTTOM:
			position.y = get_parent().size.y - size.y
		VERTICAL_ALIGNMENT_TOP:
			position.y = 0
		
	match horizontal_alignment:
		HORIZONTAL_ALIGNMENT_RIGHT:
			position.x = get_parent().size.x - size.x
		HORIZONTAL_ALIGNMENT_LEFT:
			position.x = 0
		
func set_horizontal_alignment_value(value) -> ColorLabel:
	horizontal_alignment = value
	return self

func set_vertical_alignment_value(value) -> ColorLabel:
	vertical_alignment = value
	return self
