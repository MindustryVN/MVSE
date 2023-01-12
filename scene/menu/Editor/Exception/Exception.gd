class_name LogicException
extends Node2D

var logger : Label = null

func on_click(click_position : Vector2) -> bool:
	if logger == null:
		return false
		
	if logger.get_global_rect().has_point(click_position):
		execute()
		return true
	return false
	
func execute() -> void:
	print(name + " execute not overrided")

func check() -> void:
	print(name + " check not overrided")

func print_error(content : String) -> void:
	if logger == null:
		var style = StyleBoxFlat.new()
		style.border_width_bottom = 1
		style.border_color = Color.RED
		style.bg_color = Color(0,0,0,0)
		logger = Label.new()
		logger.add_theme_stylebox_override("normal", style)
		logger.add_theme_color_override("font_color", Color.RED)
		logger.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
		logger.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		logger.size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
		var container = get_log_container()
		if container != null:
			container.add_child(logger)
	logger.text = "ERROR:" + content

func print_warning(content : String) -> void:
	if logger == null:
		var style = StyleBoxFlat.new()
		style.border_width_bottom = 1
		style.border_color = Color.GOLD
		style.bg_color = Color(0,0,0,0)
		logger = Label.new()
		logger.add_theme_stylebox_override("normal", style)
		logger.add_theme_color_override("font_color", Color.GOLD)
		logger.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
		logger.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		logger.size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
		var container = get_log_container()
		if container != null:
			container.add_child(logger)
	logger.text = "WARNING: " + content
		
func delete_log() -> void:
	if logger == null:
		return
	logger.queue_free()
	logger = null

func get_log_container() -> Object:
	return get_tree().get_first_node_in_group("LogContainer")
