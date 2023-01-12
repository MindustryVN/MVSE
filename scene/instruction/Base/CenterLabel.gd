class_name CenterLabel
extends Label

func _ready() -> void:
	horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	size = Vector2(text.length() * Config.COMPONENT_SPACE_X + 50, Config.TEXT_BOX_HEIGHT)
