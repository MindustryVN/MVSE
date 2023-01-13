class_name SelectBox
extends MenuButton



var update_before : bool = true

func is_update_before() -> bool:
	return update_before

func set_update_before(value : bool) -> SelectBox:
	update_before = value
	return self


func _ready():
	get_popup().id_pressed.connect(on_press.bind())
	get_popup().close_requested.connect(on_close.bind())
	get_popup().add_theme_font_size_override("normal", Config.EDITOR_FONT_SIZE)
	pressed.connect(on_popup.bind())
	
func update(color : Color):
	layout_mode = 0
	var style = StyleBoxFlat.new()
	style.set_bg_color(Color.BLACK)
	
	var ins_style = StyleBoxFlat.new()
	ins_style.set_bg_color(color)
	
	
	$Panel.position = (Vector2(0, Config.TEXT_BOX_HEIGHT * 3.0/4))
	$Panel.size = (Vector2(Config.TEXT_BOX_WIDTH * 0.95, Config.TEXT_BOX_HEIGHT/20))
	$Panel.add_theme_stylebox_override("panel", ins_style)
	
	$Label.position = Vector2.ZERO
	$Label.size = (Vector2(Config.TEXT_BOX_WIDTH, Config.TEXT_BOX_HEIGHT))
	
	$Label.add_theme_stylebox_override("panel", ins_style)
	style.set_border_width_all(int(Config.COMPONENT_SPACE_Y))
	style.border_color = color
	get_popup().add_theme_stylebox_override("panel", style)

	size = (Vector2(Config.TEXT_BOX_WIDTH, Config.TEXT_BOX_HEIGHT))
	
	if get_popup().item_count > 0:
		$Label.text = get_popup().get_item_text(0)

func add_option(item_name : String):
	get_popup().add_item(item_name)

func add_option_icon(item_name : String, item_icon_path : String) -> void:
	get_popup().add_icon_item(load(item_icon_path), item_name)

func add_options(item_name : Array):
	for i in item_name:
		add_option(i)
	return self

func add_option_icons(items : Dictionary):
	for i in items.keys():
		add_option_icon(i, items[i])
	return self

func on_press(id):
	$Label.text = get_popup().get_item_text(id)
	on_close()


func get_content(default : String) -> String:
	if $Label.text == "":
		return default
	return $Label.text

func is_instruction() -> bool:
	return true


func on_popup():
	Config.keyboard_focus = self
	Config.drag_focus = null


func on_close():
	Config.keyboard_focus = null
	Config.drag_focus = null
	Config.on_content_change.emit()

func unfocus():
	get_popup().hide()
	on_close()

func set_disable(value : bool) -> void:
	disabled = value
	get_popup().hide()
