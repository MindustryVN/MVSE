class_name InstructionInput
extends Node2D

var input_name : String

var update_before : bool = true

func is_update_before() -> bool:
	return update_before

func set_update_before(value : bool) -> void:
	update_before = value


func _ready():
	var style = StyleBoxFlat.new()
	style.set_bg_color(get_parent().color)
	style.set_border_width_all(1)
	style.set_border_color(Color.BLACK)
	style.set_corner_radius_all(90)
	$Panel.size = Vector2(Config.IO_CIRCLE_RADIUS,Config.IO_CIRCLE_RADIUS)
	$Panel.add_theme_stylebox_override("panel", style)
	
	add_to_group("Input")
	
	$Label.layout_mode = 0
	$Label.add_theme_font_size_override("font_size",12)
	$Label.size = Vector2(0, $Panel.size.y)
	$Label.position = Vector2(-$Panel.size.x/2 - $Label.size.x, -$Panel.size.y)

func get_code() -> Array:
	return get_parent().get_code()
	
func set_line() -> void:
	get_parent().set_line()

func has_input() -> bool:
	return true

func get_line() -> int:
	return get_parent().get_line()

func set_name(value) -> void:
	input_name = value
	$Label.text = value

func get_size() -> Vector2:
	return $Panel.size

func on_click(click_position : Vector2) -> bool:
	return Rect2(global_position, $Panel.size * scale).has_point(click_position)

func getIID() -> int:
	return get_parent().iid
