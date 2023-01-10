extends PanelContainer

var is_resizing : bool = false

func _input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			if event.button_index == MOUSE_BUTTON_LEFT:
				on_click(get_global_mouse_position())
		else:
			on_release()
	elif event is InputEventMouseMotion:
		on_drag(event, get_global_mouse_position())

func on_click(click_position : Vector2) -> void:
	# Resize live code window
	if abs(click_position.x - global_position.x) <= 4:
		Config.is_resizing = true
		is_resizing = true
		return

func on_release():
	Config.is_resizing = false
	is_resizing = false

func on_drag(_event, drag_position : Vector2) -> void:
	if Config.is_resizing and is_resizing:
		var mouse_screen_position : Vector2 = drag_position
		global_position.x = clamp(mouse_screen_position.x , get_viewport_rect().size.x * (Config.MIN_LIVE_CODE_SIZE + 0.5), get_viewport_rect().size.x * (Config.MAX_LIVE_CODE_SIZE + 0.5))
		size.x = get_viewport_rect().size.x - global_position.x 
		return
