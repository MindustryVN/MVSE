class_name Instruction  
extends Panel

var instruction_name

var style : StyleBoxFlat = StyleBoxFlat.new()
var color : Color = Config.INSTRUCTION_COLOR["FLOW_CONTROL"]
var content : String = ""

var has_input : bool = true
var has_output : bool = true

var input = {}
var output = {}

var line = -1

signal on_drag
signal on_content_change
signal on_ready

func _ready():
	abtr()
	style.set_bg_color(color)
	add_theme_stylebox_override("panel", style)
	
	call_deferred("_update", color)

func set_disable(value : bool) -> void:
	for child in get_children():
		if child.has_method("set_disable"):
			child.set_disable(value) 

func set_line(current_line) -> void:
	self.line = current_line
	for o in output.values():
		o.set_line(current_line + 1)

func get_code() -> Array:
	var result : Array = []
	result.append_array(get_content())
	for o in output.values():
		result.append_array(o.get_code())
	return result 

func abtr() -> void:
	pass

func get_content() -> Array:
	return []

func _update(_color : Color):

	var children = get_children(false)
	var count = children.size()
	
	for i in range(0,count):
		if Config.is_instruction_component(children[i]):
			children[i]._update(_color)
	
	var x = Config.COMPONENT_SPACE_X
	var y = Config.COMPONENT_SPACE_Y
	
	for i in range(0, count):
		children[i].position = Vector2(Config.COMPONENT_SPACE_X, y )
		
		x = max(children[i].size.x + Config.COMPONENT_SPACE_X, x) 
		y += (children[i].size.y) 
		
	size = Vector2(max(x + Config.COMPONENT_SPACE_X, Config.BASE_WIDTH),max(y + Config.COMPONENT_SPACE_Y, Config.BASE_MIN_HEIGHT))
	set_default_io()
	on_ready.emit()

	
func delete() -> void:
	call_deferred("queue_free")
		
func add_output(output_name : String):
	var ins = load("res://scene/instruction/base/InstructionOutput.tscn").instantiate()
	ins.set_name( output_name) 
	output[output_name] = ins

func add_input(input_name : String):
	var ins = load("res://scene/instruction/base/InstructionInput.tscn").instantiate()
	ins.set_name( input_name) 
	input[input_name] = ins


func drag(pos : Vector2):
	global_position = pos
	on_drag.emit()

func set_default_io():
	var output_size : int = output.size()
	for i in range(0, output_size):
		call_deferred("add_child",output.values()[i])
		output.values()[i].position = Vector2(Config.IO_CIRCLE_RADIUS / 2 + size.x , (i + 1) * (size.y/(output_size + 1)) - Config.IO_CIRCLE_RADIUS/2 )
	
	var input_size : int = input.size()
	for i in range(0, input_size):
		call_deferred("add_child",input.values()[i])
		input.values()[i].position = Vector2(- Config.IO_CIRCLE_RADIUS * 1.5, (i + 1) * (size.y/(input_size + 1)) - Config.IO_CIRCLE_RADIUS/2 )
	
func get_line() -> int:
	return line

func on_click() -> bool:
	return Rect2(global_position, size * scale).has_point(get_global_mouse_position())
