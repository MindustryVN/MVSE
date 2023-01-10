class_name InstructionOutput
extends Panel


var connected : bool = false
var output_name : String

var disable : bool = false

var target : InstructionInput = null

func _ready():
	var style = StyleBoxFlat.new()
	style.set_bg_color(get_parent().color)
	style.set_border_width_all(1)
	style.set_border_color(Color.BLACK)
	style.set_corner_radius_all(90)
	size = Vector2(Config.IO_CIRCLE_RADIUS,Config.IO_CIRCLE_RADIUS)
	
	add_to_group("Drag")
	add_theme_stylebox_override("panel", style)
	
	get_parent().on_drag.connect(drop.bind())
	
	$Label.layout_mode = 0
	$Label.add_theme_font_size_override("font_size",12)
	$Label.size = Vector2(0, size.y)
	$Label.position = Vector2(size.x, -size.y)
	
	$Line2D.width = Config.IO_CIRCLE_RADIUS / 3
	
	var start = get_start_position() 
	var end = get_start_position()
	var control1 = Vector2(end.x, start.y)
	var control2 = Vector2(start.x, end.y)
	
	var i : float = 0
	while(i <= Config.CONNECTION_SEGMENT):
		$Line2D.add_point(_cubic_bezier(start, control1, control2, end,i / Config.CONNECTION_SEGMENT))
		i += 1

func set_name(value) -> void:
	output_name = value
	$Label.text = value

func get_start_position() -> Vector2:
	return $Line2D.to_local(global_position)  + size/2 

func drop():
	var start = get_start_position()
	var end = get_end_position()
	update_line(start,end)
	
func get_end_position() -> Vector2:
	if target == null:
		return get_start_position()
	else:
		return $Line2D.to_local(target.global_position) + target.size/2

func set_end_position(pos : Vector2):
	if disable:
		reset()
		return
		
	var start = get_start_position()
	var end = $Line2D.to_local(pos)
	update_line(start, end)

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
	target = null
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

func connect_instruction(obj) -> void:
	get_parent().on_content_change.emit()
	if obj == null or obj.get_parent() == get_parent() or not obj.has_input():
		reset()
		get_parent().on_content_change.emit()
		return
	target = obj
	
	if target.get_parent().on_drag.is_connected(drop.bind()):
		return
		
	target.get_parent().on_drag.connect(drop.bind())
	$Line2D.gradient = Gradient.new()
	$Line2D.gradient.set_color(0, get_parent().color)
	$Line2D.gradient.set_color(1, target.get_parent().color)
	get_parent().on_content_change.emit()
	
func disconnect_instruction() -> void:
	if target != null:
		target.on_drag.disconnect(drop.bind())
		target = null
		get_parent().on_content_change.emit()

func get_code() -> Array:
	if target == null:
		return ["end"]
	elif target.get_line() <= get_parent().get_line():
		return ["jump " + str(target.get_line()) + " always x false"]
	return target.get_code()

func get_line() -> int:
	if target == null:
		return -1
	else:
		return target.get_line()

func set_line(current_line) -> void:
	if target == null:
		return
	target.set_line(current_line)

func set_disable(value : bool) -> void:
	disable = value


func on_click() -> bool:
	return get_global_rect().has_point(get_global_mouse_position())
