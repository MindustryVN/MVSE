class_name Instruction 
extends Node2D

var instruction_name

var color : Color = Config.INSTRUCTION_COLOR["FLOW_CONTROL"]
var content : String = ""
var input : Dictionary = {}
var output : Dictionary = {}

var component : Dictionary = {}

var disabled : bool = false

var line = -1

signal on_drag
signal on_content_change
signal on_ready
signal on_delete

func _init(ins_name) -> void:
	instruction_name = ins_name
	
func _ready() -> void:
	if not component.has("InstructionBackground"):
		component["InstructionBackground"] = load(Config.COMPONENT_TYPE["InstructionBackground"]).instantiate()
	add_component("row", "BaseRow", null)
	add_component("line1", "BaseLine", "row")
	add_component("title", "ColorLabel", "line1").text = instruction_name.capitalize()
	add_child(component["InstructionBackground"])
	setup()
	update(color)

func set_disable(value : bool) -> void:
	if value == true:
		remove_from_group("Start")
	for child in get_children():
		if child.has_method("set_disable"):
			child.set_disable(value) 

func set_line() -> void:
	if line != -1:
		return
	Config.current_line += 1
	self.line = Config.current_line
	for o in output.values():
		o.set_line()

func get_size() -> Vector2:
	return component["InstructionBackground"].size


func get_code() -> Array:
	var result : Array = []
	result.append_array(get_content())
	for o in output.values():
		result.append_array(o.get_code())
	return result 

func setup() -> void:
	print(instruction_name + " setup not overrided")
	

func get_content() -> Array:
	return [instruction_name + " get content not overrided"]

func get_component_value(component_name, default : String) -> String:
	return component[component_name].get_content(default)

func update(_color : Color):
	var children = get_children()
	var count = children.size()
	
	for i in range(0, count):
		if Config.is_instruction_component(children[i]):
			children[i]._update(_color)
	on_ready.emit()

	
func delete() -> void:
	on_content_change.emit()
	on_delete.emit()
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
	top_level = true
	on_drag.emit()

func drop():
	top_level = false

func get_line() -> int:
	return line

func on_click(click_position : Vector2) -> bool:
	return component["InstructionBackground"].on_click(click_position)

func add_component(component_name, component_type, parent):
	var com = load(Config.COMPONENT_TYPE[component_type]).instantiate()
	component[component_name] = com
	if parent == null:
		component["InstructionBackground"].add_child(com)
	else:
		component[parent].add_child(com)
	return com
