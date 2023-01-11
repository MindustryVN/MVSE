extends PanelContainer

var is_resizing : bool = false

func on_click() -> bool:
	# Resize live code window
	if abs(get_global_mouse_position().x - global_position.x) <= 4:
		Config.is_resizing = true
		is_resizing = true
		return true
	return false

func on_release() -> void:
	Config.is_resizing = false
	is_resizing = false

func on_drag() -> bool:
	if Config.is_resizing and is_resizing:
		global_position.x = clamp(get_global_mouse_position().x , get_viewport_rect().size.x * (Config.MIN_LIVE_CODE_SIZE + 0.5), get_viewport_rect().size.x * (Config.MAX_LIVE_CODE_SIZE + 0.5))
		size.x = get_viewport_rect().size.x - global_position.x 
		return true
	return false
