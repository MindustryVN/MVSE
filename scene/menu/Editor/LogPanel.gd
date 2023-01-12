extends PanelContainer

var is_resizing : bool = false

func _ready() -> void:
	size.y = get_viewport_rect().size.y/5

func on_click(click_position : Vector2) -> bool:
	# Resize live code window
	if abs(click_position.y - global_position.y) > 5:
		return false
	if (click_position.x > global_position.x + size.x):
		return false
	if (click_position.x < global_position.x):
		return false
	Config.is_resizing = true
	is_resizing = true
	return true


func on_release() -> void:
	Config.is_resizing = false
	is_resizing = false

func on_drag(drag_position : Vector2) -> bool:
	if Config.is_resizing and is_resizing:
		global_position.y = clamp(drag_position.y , get_viewport_rect().size.y * (1 - Config.MAX_LIVE_CODE_SIZE), get_viewport_rect().size.y * (1 - Config.MIN_LIVE_CODE_SIZE ))
		size.y = get_viewport_rect().size.y - global_position.y 
		return true
	return false


func _on_live_code_panel_resized() -> void:
	on_resize()

func _on_schematic_panel_resized() -> void:
	on_resize()

func on_resize():
	if is_inside_tree():
		global_position.x = $"../SchematicPanel".get_visible_size().x
		size.x = $"../LiveCodePanel".get_visible_position().x - global_position.x
		size.y = get_viewport_rect().size.y - global_position.y

func _on_schematic_panel_visibility_changed() -> void:
	on_resize()

func _on_live_code_panel_visibility_changed() -> void:
	on_resize()
