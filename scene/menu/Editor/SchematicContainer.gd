extends PanelContainer

var is_resizing : bool = false

@onready var LINE_EDIT : LineEdit = $VBoxContainer/SearchBox

func _ready():
	LINE_EDIT.focus_entered.connect(_on_line_edit_focus_entered.bind())
	LINE_EDIT.focus_exited.connect(_on_line_edit_focus_exited.bind())

func on_click() -> bool:
	# Resize live code window
	if abs(get_global_mouse_position().x - global_position.x - size.x) <= 4:
		Config.is_resizing = true
		is_resizing = true
		return true
	return false

func on_release():
	Config.is_resizing = false
	is_resizing = false

func on_drag() -> bool:
	if Config.is_resizing and is_resizing:
		size.x = clamp(get_global_mouse_position().x , get_viewport_rect().size.x * (Config.MIN_LIVE_CODE_SIZE),get_viewport_rect().size.x * (Config.MAX_LIVE_CODE_SIZE))
		return true
	return false


func _on_line_edit_focus_entered():
	Config.keyboard_focus = self

func _on_line_edit_focus_exited():
	Config.keyboard_focus = null
	Config.on_content_change.emit()


func unfocus():
	LINE_EDIT.release_focus()
