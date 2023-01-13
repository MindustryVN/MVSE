class_name BaseRow
extends Control



var update_before : bool = true

func is_update_before() -> bool:
	return update_before

func set_update_before(value : bool) -> BaseRow:
	update_before = value
	return self

func is_instruction() -> bool:
	return true

func update(color : Color):
	layout_mode = 0
	var children = get_children(false)
	var count = children.size()

	var max_width = 0
	for i in range(0,count):
		if Config.is_instruction_component(children[i]):
			children[i].update(color)
	
	for i in range(0,count):
		if children[i].size.x > max_width:
			max_width = children[i].size.x
	
	var y = 0
	for i in range(0, count):
		children[i].position = Vector2( 0, y)
		y += (children[i].size.y) 

	size = Vector2(max_width, y)

	
func set_disable(value : bool) -> void:
	for child in get_children():
		if child.has_method("set_disable"):
			child.set_disable(value) 
