extends PanelContainer

var is_resizing : bool = false
var e

func _ready() -> void:
	var style = StyleBoxFlat.new()
	style.border_width_left = Config.PANEL_BORDER_SIZE
	style.border_blend = true
	style.border_color = Config.PANEL_BORDER_COLOR
	style.bg_color = Config.PANEL_BACKGROUND_COLOR
	add_theme_stylebox_override("panel",style)
	size.x = get_viewport_rect().size.x/5

func _input(event: InputEvent) -> void:
	e = event

func on_click() -> bool:
	# Resize live code window
	if e == null:
		return false
	var click_position : Vector2 = e.position
	
	if abs(click_position.x - global_position.x) <= Config.PANEL_BORDER_SIZE:
		Config.is_resizing = true
		is_resizing = true
		return true
	return false

func on_release() -> void:
	Config.is_resizing = false
	is_resizing = false

func on_drag() -> bool:
	if e == null:
		return false
	var drag_position : Vector2 = e.position
	if Config.is_resizing and is_resizing:
		global_position.x = clamp(drag_position.x , get_viewport_rect().size.x * (1 - Config.MAX_LIVE_CODE_SIZE), get_viewport_rect().size.x * (1 - Config.MIN_LIVE_CODE_SIZE))
		size.x = get_viewport_rect().size.x - global_position.x 
		return true
	return false

func get_visible_position() -> Vector2:
	if visible:
		return global_position
	return get_viewport_rect().size


func get_visible_size() -> Vector2:
	if visible:
		return size
	return Vector2.ZERO
		
