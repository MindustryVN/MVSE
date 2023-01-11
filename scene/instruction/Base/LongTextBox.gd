class_name LongTextBox
extends Control

func _ready():
	focus_entered.connect(_on_line_edit_focus_entered.bind())
	focus_exited.connect(_on_line_edit_focus_exited.bind())

func is_instruction() -> bool:
	return true

func _update(color : Color):
	layout_mode = 0
	var style = StyleBoxFlat.new()
	style.set_bg_color(Color.BLACK)
	$Panel.add_theme_stylebox_override("panel", style)
	$Panel/LineEdit.add_theme_stylebox_override("focus", style)
	$Panel/LineEdit.add_theme_stylebox_override("normal", style)
	
	size = (Vector2(Config.BASE_WIDTH, Config.TEXT_BOX_HEIGHT))
	$Panel.size = (Vector2(Config.BASE_WIDTH, Config.TEXT_BOX_HEIGHT))
	
	$Panel/LineEdit.position = (Vector2(Config.BASE_WIDTH * 0.05, 0))
	$Panel/LineEdit.size = (Vector2(Config.BASE_WIDTH * 0.95, Config.TEXT_BOX_HEIGHT))
	var ins_style = StyleBoxFlat.new()
	ins_style.set_bg_color(color)
	$Panel/LineEdit/Panel.position = (Vector2(0, Config.TEXT_BOX_HEIGHT * 2.0/3))
	$Panel/LineEdit/Panel.size = (Vector2(Config.BASE_WIDTH * 0.95, Config.TEXT_BOX_HEIGHT/20))
	$Panel/LineEdit/Panel.add_theme_stylebox_override("panel", ins_style)

func get_content(default : String) -> String:
	if $Panel/LineEdit.get_text() == "":
		return default
	return $Panel/LineEdit.get_text()


func _on_line_edit_focus_entered():
	Config.keyboard_focus = self


func _on_line_edit_focus_exited():
	Config.keyboard_focus = null
	Config.on_content_change.emit()

func unfocus():
	$Panel/LineEdit.release_focus()
	
func set_disable(value : bool) -> void:
	$Panel/LineEdit.editable = not value
	
