class_name InstructionInput
extends Panel

var input_name : String

func _ready():
	var style = StyleBoxFlat.new()
	style.set_bg_color(get_parent().color)
	style.set_border_width_all(1)
	style.set_border_color(Color.BLACK)
	style.set_corner_radius_all(90)
	size = Vector2(Config.IO_CIRCLE_RADIUS,Config.IO_CIRCLE_RADIUS)
	add_theme_stylebox_override("panel", style)
	
	add_to_group("Input")
	
	$Label.layout_mode = 0
	$Label.add_theme_font_size_override("font_size",12)
	$Label.size = Vector2(0, size.y)
	$Label.position = Vector2(-size.x/2 - $Label.size.x, -size.y)

func get_code() -> Array:
	return get_parent().get_code()
	
func set_line(current_line : int) -> void:
	get_parent().set_line(current_line)

func has_input() -> bool:
	return true

func get_line() -> int:
	return get_parent().get_line()

func set_name(value) -> void:
	input_name = value
	$Label.text = value


func on_click() -> bool:
	return get_global_rect().has_point(get_global_mouse_position())

