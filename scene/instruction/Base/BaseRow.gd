class_name BaseRow
extends Control

func is_instruction() -> bool:
	return true

func _update(color : Color):
	layout_mode = 0
	var children = get_children(false)
	var count = children.size()

	var max_width = 0
	for i in range(0,count):
		if Config.is_instruction_component(children[i]):
			children[i]._update(color)
	
	for i in range(0,count):
		if children[i].size.x > max_width:
			max_width = children[i].size.x
	
	var y = Config.COMPONENT_SPACE_Y
	for i in range(0, count):
		children[i].position = Vector2( 0, y)
		y += (children[i].size.y) 

	size = Vector2(max_width, y + Config.COMPONENT_SPACE_Y)
	
func set_disable(value : bool) -> void:
	for child in get_children():
		if child.has_method("set_disable"):
			child.set_disable(value) 
