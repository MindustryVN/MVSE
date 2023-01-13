class_name CenterLabel
extends Label

var update_before : bool = true

func is_update_before() -> bool:
	return update_before

func set_update_before(value : bool) -> CenterLabel:
	update_before = value
	return self

func _ready() -> void:
	layout_mode = 0
	size = Vector2(text.length() * Config.COMPONENT_SPACE_X + 50, Config.TEXT_BOX_HEIGHT/2)
	Config.on_content_change.connect(resize.bind())
	horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	vertical_alignment = VERTICAL_ALIGNMENT_CENTER
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
	
func set_horizontal_alignment_value(value) -> CenterLabel:
	horizontal_alignment = value
	return self

func set_vertical_alignment_value(value) -> CenterLabel:
	vertical_alignment = value
	return self
