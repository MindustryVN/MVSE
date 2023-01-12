class_name InstructionOutput
extends Node2D


var connected : bool = false
var output_name : String

var disable : bool = false

@export var target : InstructionInput = null

func _ready() -> void:
	var style = StyleBoxFlat.new()
	style.set_bg_color(get_parent().color)
	style.set_border_width_all(1)
	style.set_border_color(Color.BLACK)
	style.set_corner_radius_all(90)
	$Panel.size = Vector2(Config.IO_CIRCLE_RADIUS,Config.IO_CIRCLE_RADIUS)
	
	add_to_group("Drag")
	$Panel.add_theme_stylebox_override("panel", style)
	
	get_parent().on_drag.connect(drop.bind())
	
	$Label.layout_mode = 0
	$Label.size = Vector2(0, $Panel.size.y)
	$Label.position = Vector2($Panel.size.x, -$Panel.size.y)
	$Label.add_theme_font_size_override("font_size",12)
	
	$Line2D.width = Config.IO_CIRCLE_RADIUS / 3
	
	var start = get_start_position() 
	var end = get_start_position()
	var control1 = Vector2(end.x, start.y)
	var control2 = Vector2(start.x, end.y)
	
	var i : float = 0
	while(i <= Config.CONNECTION_SEGMENT):
		$Line2D.add_point(_cubic_bezier(start, control1, control2, end,i / Config.CONNECTION_SEGMENT))
		i += 1

func get_start_position() -> Vector2:
	return $Line2D.to_local(global_position)  + $Panel.size/2 

func get_end_position() -> Vector2:
	if not is_instance_valid(target) or target == null:
		return get_start_position()
	else:
		return $Line2D.to_local(target.global_position) + target.get_size()/2

func drop() -> void:
	var start = get_start_position()
	var end = get_end_position()
	update_line(start,end)

func on_click(click_position : Vector2) -> bool:
	return Rect2(global_position, $Panel.size * scale).has_point(click_position)

func on_drag(pos : Vector2) -> void:
	if disable:
		reset()
		return
	var start = get_start_position()
	var end = $Line2D.to_local(pos)
	update_line(start, end)
	disconnect_instruction()

func update_line(start : Vector2, end : Vector2)  -> void:
	var control1 = Vector2(end.x, start.y)
	var control2 = Vector2(start.x , end.y)
	if start.x > end.x:
		control1 = Vector2(start.x, end.y)
		control2 = Vector2(end.x, start.y)
		
	var i : float = 0
	while(i <= Config.CONNECTION_SEGMENT):
		$Line2D.set_point_position(i,_cubic_bezier(start, control1, control2, end, i / Config.CONNECTION_SEGMENT))
		i += 1

func reset()  -> void:
	var start = get_start_position()
	var end = get_start_position()
	update_line(start, end)


func _cubic_bezier(p0: Vector2, p1: Vector2, p2: Vector2, p3: Vector2, t: float) -> Vector2:
	var q0 = p0.lerp(p1, t)
	var q1 = p1.lerp(p2, t)
	var q2 = p2.lerp(p3, t)

	var r0 = q0.lerp(q1, t)
	var r1 = q1.lerp(q2, t)

	var s = r0.lerp(r1, t)
	return s

func connect_instruction(obj : InstructionInput) -> void:
	if obj == null or not obj.has_input():
		reset()
		return
	target = obj

	$Line2D.gradient = Gradient.new()
	$Line2D.gradient.set_color(0, get_parent().color)
	$Line2D.gradient.set_color(1, target.get_parent().color)
	if target.get_parent().on_drag.is_connected(drop.bind()):
		return
	
	if target.get_parent().on_delete.is_connected(reset.bind()):
		return
	
	update_line(get_start_position(), get_end_position())
	target.get_parent().on_drag.connect(drop.bind())
	target.get_parent().on_delete.connect(reset.bind())
	get_parent().on_content_change.emit()
	
func disconnect_instruction() -> void:
	if target != null:
		target.get_parent().on_drag.disconnect(drop.bind())
		target = null
		get_parent().on_content_change.emit()

func get_code() -> Array:
	if not is_instance_valid(target):
		return ["end"]
	elif target.get_line() <= get_parent().get_line():
		return ["jump " + str(target.get_line()) + " always x false"]
	return target.get_code()

func get_line() -> int:
	if target == null:
		return -1
	else:
		return target.get_line()

func set_line() -> void:
	if target == null:
		return
	target.set_line()

func set_disable(value : bool) -> void:
	disable = value

func get_size() -> Vector2:
	return $Panel.size

func set_name(value) -> void:
	output_name = value
	$Label.text = value

func get_target_name() -> String:
	if target == null:
		return ""
	return target.input_name

func getIID() -> int:
	return get_parent().iid

func get_target_iid() -> int:
	if target == null:
		return -1
	return target.getIID()
