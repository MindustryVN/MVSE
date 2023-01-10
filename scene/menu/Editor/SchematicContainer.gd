extends PanelContainer

var is_resizing : bool = false

@onready var LINE_EDIT : LineEdit = $VBoxContainer/LineEdit

func _ready():
	LINE_EDIT.focus_entered.connect(_on_line_edit_focus_entered.bind())
	LINE_EDIT.focus_exited.connect(_on_line_edit_focus_exited.bind())

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
	if abs(click_position.x - global_position.x - size.x) <= 4:
		Config.is_resizing = true
		is_resizing = true
		return

func on_release():
	Config.is_resizing = false
	is_resizing = false

func on_drag(_event, drag_position : Vector2) -> void:
	if Config.is_resizing and is_resizing:
		var mouse_screen_position : Vector2 = drag_position
		size.x = clamp(mouse_screen_position.x , get_viewport_rect().size.x * (Config.MIN_LIVE_CODE_SIZE), get_viewport_rect().size.x * (Config.MAX_LIVE_CODE_SIZE))
		return


func _on_line_edit_focus_entered():
	Config.keyboard_focus = self

func _on_line_edit_focus_exited():
	Config.keyboard_focus = null
	Config.on_content_change.emit()


func unfocus():
	LINE_EDIT.release_focus()
