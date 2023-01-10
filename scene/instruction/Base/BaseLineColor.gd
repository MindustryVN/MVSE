class_name BaseLineColor
extends Panel

func is_instruction() -> bool:
	return true

func _ready():
	var style = StyleBoxFlat.new()
	style.set_bg_color(Color("000000"))
	add_theme_stylebox_override("panel", style)

func _update(color : Color):
	layout_mode = 0
	
	var children = get_children(false)
	var count = children.size()
	
	var max_height = 0
	for i in range(0,count):
		if Config.is_instruction_component(children[i]):
			children[i]._update(color)
		if children[i].size.y > max_height:
			max_height = children[i].size.y
			
	
	
	var x = Config.COMPONENT_SPACE_X
	for i in range(0, count):
		children[i].position = (Vector2(x, (max_height - children[i].size.y) / 2 ))
		x += (Config.COMPONENT_SPACE_X + children[i].size.x) 

	self.size.x = max(x, Config.BASE_WIDTH)
	if max_height == 0:
		self.size.y = Config.TEXT_BOX_HEIGHT
	else: 
		self.size.y = max(max_height, Config.BASE_MIN_HEIGHT)
	
func set_disable(value : bool) -> void:
	for child in get_children():
		if child.has_method("set_disable"):
			child.set_disable(value) 
