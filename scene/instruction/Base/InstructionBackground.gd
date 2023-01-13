class_name InstructionBackground
extends Panel


var update_before : bool = true

func is_update_before() -> bool:
	return update_before

func set_update_before(value : bool) -> InstructionBackground:
	update_before = value
	return self

func is_instruction() -> bool:
	return true
	

func update(_color : Color) -> void:
	layout_mode = 0
	var style : StyleBoxFlat = StyleBoxFlat.new()
	style.set_bg_color(_color)
	add_theme_stylebox_override("panel", style)
	
	var children = get_children(false)
	var count = children.size()
	
	var x = Config.COMPONENT_SPACE_X
	var y = Config.COMPONENT_SPACE_Y
	
	for i in range(0, count):
		if Config.is_instruction_component(children[i]) and children[i].is_update_before():
			children[i].update(_color)
	
	for i in range(0, count):
		children[i].position = Vector2(Config.COMPONENT_SPACE_X, y )
		if Config.is_instruction_component(children[i]):
			x = max(children[i].size.x + Config.COMPONENT_SPACE_X, x) 
			y += (children[i].size.y) 
		
	size = Vector2(max(x + Config.COMPONENT_SPACE_X, Config.BASE_WIDTH),max(y + Config.COMPONENT_SPACE_Y, Config.BASE_MIN_HEIGHT))
	
	for i in range(0, count):
		if Config.is_instruction_component(children[i]) and not children[i].is_update_before():
			children[i].update(_color)
			
	set_default_io(get_parent().input, get_parent().output)

	
func set_default_io(input : Dictionary, output : Dictionary):
	var output_size : int = output.size()
	for i in range(0, output_size):
		get_parent().call_deferred("add_child",output.values()[i])
		output.values()[i].position = Vector2(Config.IO_CIRCLE_RADIUS / 2 + size.x , (i + 1) * (size.y/(output_size + 1)) - Config.IO_CIRCLE_RADIUS/2 )
	
	var input_size : int = input.size()
	for i in range(0, input_size):
		get_parent().call_deferred("add_child",input.values()[i])
		input.values()[i].position = Vector2(- Config.IO_CIRCLE_RADIUS * 1.5, (i + 1) * (size.y/(input_size + 1)) - Config.IO_CIRCLE_RADIUS/2 )


func on_click(click_position : Vector2) -> bool:
	return Rect2(global_position, size * get_parent().scale).has_point(click_position)

func set_disable(value : bool) -> void:
	for child in get_children():
		if child.has_method("set_disable"):
			child.set_disable(value) 
