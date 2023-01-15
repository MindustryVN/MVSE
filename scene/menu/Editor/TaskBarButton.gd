extends MenuButton


func _ready() -> void:
	var style = StyleBoxFlat.new()
	style.border_width_bottom = Config.PANEL_BORDER_SIZE
	style.border_width_top = Config.PANEL_BORDER_SIZE
	style.border_color = Config.PANEL_BORDER_COLOR
	style.border_blend = true
	style.bg_color = Config.PANEL_BACKGROUND_COLOR
	get_popup().add_theme_stylebox_override("panel",style)
	get_popup().id_pressed.connect(on_item_checked.bind())


func on_item_checked(id) -> void:
	match id:
		0:
			$"../../../LiveCodePanel".visible = get_popup().is_item_checked(id)
		1: 
			$"../../../SchematicPanel".visible = get_popup().is_item_checked(id)
