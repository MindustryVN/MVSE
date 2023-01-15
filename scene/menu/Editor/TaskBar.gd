extends MenuBar


@onready var PANEL : Panel = $Panel


func _ready() -> void:
	var style = StyleBoxFlat.new()
	style.border_width_bottom = Config.PANEL_BORDER_SIZE
	style.border_width_top = Config.PANEL_BORDER_SIZE
	style.border_color = Config.PANEL_BORDER_COLOR
	style.border_blend = true
	style.bg_color = Config.PANEL_BACKGROUND_COLOR
	PANEL.add_theme_stylebox_override("panel",style)
