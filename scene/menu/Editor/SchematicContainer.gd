extends PanelContainer

var is_resizing : bool = false

@onready var LINE_EDIT : LineEdit = $VBoxContainer/SearchBox

func _ready():
	LINE_EDIT.focus_entered.connect(_on_line_edit_focus_entered.bind())
	LINE_EDIT.focus_exited.connect(_on_line_edit_focus_exited.bind())
	
	var style = StyleBoxFlat.new()
	style.set_border_width_all(2)
	style.border_width_right = Config.PANEL_BORDER_SIZE
	style.border_color = Config.PANEL_BORDER_COLOR
	style.bg_color = Config.PANEL_BACKGROUND_COLOR
	style.border_blend = true
	add_theme_stylebox_override("panel",style)
	
	size.x = get_viewport_rect().size.x/5
	

func on_click(click_position : Vector2) -> bool:
	# Resize live code window
	if abs(click_position.x - global_position.x - size.x) <= Config.PANEL_BORDER_SIZE:
		Config.is_resizing = true
		is_resizing = true
		return true
	return false

func on_release():
	Config.is_resizing = false
	is_resizing = false

func on_drag(drag_position : Vector2) -> bool:
	if Config.is_resizing and is_resizing:
		size.x = clamp(drag_position.x , get_viewport_rect().size.x * (Config.MIN_LIVE_CODE_SIZE),get_viewport_rect().size.x * (Config.MAX_LIVE_CODE_SIZE))
		return true
	return false


func _on_line_edit_focus_entered():
	Config.keyboard_focus = self

func _on_line_edit_focus_exited():
	Config.keyboard_focus = null
	Config.on_content_change.emit()


func unfocus():
	LINE_EDIT.release_focus()

func get_visible_position() -> Vector2:
	if visible:
		return position
	return Vector2.ZERO

func get_visible_size() -> Vector2:
	if visible:
		return size
	return Vector2.ZERO
		
