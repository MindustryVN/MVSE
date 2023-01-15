extends PanelContainer

var is_resizing : bool = false
var e

func _ready() -> void:
	var style = StyleBoxFlat.new()
	style.border_width_top = Config.PANEL_BORDER_SIZE
	style.border_color = Config.PANEL_BORDER_COLOR
	style.border_blend = true
	style.bg_color = Config.PANEL_BACKGROUND_COLOR
	add_theme_stylebox_override("panel",style)
	size.y = get_viewport_rect().size.y/5

func _input(event: InputEvent) -> void:
	e = event

func on_click() -> bool:
	# Resize live code window
	if e == null:
		return false
	var click_position : Vector2 = e.position
	if abs(click_position.y - global_position.y) > Config.PANEL_BORDER_SIZE:
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

func on_drag() -> bool:
	if e == null:
		return false
	var drag_position : Vector2 = e.position
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

func _on_live_code_panel_item_rect_changed() -> void:
	on_resize()
