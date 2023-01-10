extends Node2D

@onready var POSITION_LABEL : Label = $EditorUI/SettingUI/VFlowContainer/Label
@onready var MOUSE_POSITION_LABEL : Label = $EditorUI/SettingUI/VFlowContainer/Label2
@onready var FPS_LABEL : Label = $EditorUI/SettingUI/VFlowContainer/Label3

@onready var SCHEMATIC_SHOW_BUTTON : CheckBox = $EditorUI/SettingUI/VBoxContainer/Schematic
@onready var LIVECODE_SHOW_BUTTON : CheckBox = $EditorUI/SettingUI/VBoxContainer/LiveCode
@onready var SCHEMATIC_PANEL : PanelContainer = $EditorUI/SchematicPanel
@onready var LIVECODE_PANEL : PanelContainer = $EditorUI/LiveCodePanel 

@onready var SCHEMATIC_CONTAINER  = $EditorUI/SchematicPanel/VBoxContainer/HBoxContainer/PanelContainer

@onready var SETTING_UI = $EditorUI/SettingUI

var instruction : Dictionary = {}

func _process(_delta):
	POSITION_LABEL.text = "Postion:" + str($Camera2D.global_position)
	MOUSE_POSITION_LABEL.text =  "Mouse Position:" + str(get_global_mouse_position())
	FPS_LABEL.text = "  FPS:"  + str(Engine.get_frames_per_second()) 
	
func _draw():
	draw_line(Vector2(10000,0), Vector2(-10000,0), Color.GREEN)
	draw_line(Vector2(0,10000), Vector2(0,-10000), Color.GREEN)

func _ready():
	Config.on_content_change.connect(update_live_code.bind())
	get_viewport().size_changed.connect(resize.bind())
	resize()
	SCHEMATIC_SHOW_BUTTON.toggled.connect(show_schematic.bind())
	LIVECODE_SHOW_BUTTON.toggled.connect(show_live_code.bind())
	
	
	var directory = ["res://scene/instruction/BlockControl",
	"res://scene/instruction/FlowControl",
	"res://scene/instruction/InputOutput",
	"res://scene/instruction/Operation",
	"res://scene/instruction/UnitControl"]
	
	

	for path in directory:

		var dir =  DirAccess.open(path)
		dir.list_dir_begin()

		while true:
			var file = dir.get_next()
			if file == "":
				break
			elif not file.begins_with(".") and file.ends_with(".tscn"):
				instruction[file.replace(".tscn", "")] = path + "/" + file
				
		dir.list_dir_end()
	
	var start = Vector2(Config.IO_CIRCLE_RADIUS * 2, 0)
	
	for ins_name in instruction.keys():
		var ins : Instruction = load(instruction[ins_name]).instantiate()
		ins.global_position = start
		ins.on_content_change.connect(update_live_code.bind())
		ins.add_to_group("SchematicPreview")
		ins.set_disable(true)
		ins.instruction_name = ins_name
		ins.scale = Vector2(Config.EDITOR_SCHEMATIC_SCALE,Config.EDITOR_SCHEMATIC_SCALE)
		SCHEMATIC_CONTAINER.call_deferred("add_child", ins)
		await ins.on_ready
		start.y += (ins.size.y + Config.COMPONENT_SPACE_Y) * Config.EDITOR_SCHEMATIC_SCALE 
		
		
func resize():
	var view : Rect2 = get_viewport_rect()
	SETTING_UI.position = Vector2.ZERO
	SETTING_UI.size = Vector2(view.size.x, Config.TOOL_BAR_HEIGHT)
	
	LIVECODE_PANEL.position = Vector2(view.size.x - LIVECODE_PANEL.size.x, 0)
	LIVECODE_PANEL.size.y = view.size.y
	
	SCHEMATIC_PANEL.position = Vector2(0, SETTING_UI.size.y)
	SCHEMATIC_PANEL.size.y =  view.size.y - SETTING_UI.size.y
	
	
func show_live_code(value : bool):
	LIVECODE_PANEL.visible = value
	
func show_schematic(value : bool):
	SCHEMATIC_PANEL.visible = value
	
func _input(event):
	if Config.is_resizing:
		return
	if Config.is_crolling:
		return
	
	if event is InputEventMouseButton:
		if event.pressed:
			if event.button_index == MOUSE_BUTTON_LEFT:
				on_left_click(get_global_mouse_position())
			if event.button_index == MOUSE_BUTTON_RIGHT:
				# Delete instruction
				var obj = Config.get_node_at_mouse_position("Instruction")
				if obj:
					obj.delete()
		else:
			on_left_release()
			#Zoom
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			on_zoom(Config.zoom / Config.ZOOM_FACTOR)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			on_zoom(Config.zoom * Config.ZOOM_FACTOR)
			

	elif event is InputEventMouseMotion:
		on_drag(event, get_global_mouse_position())


func on_zoom(zoom_value : float) -> void:
	Config.current_camera = get_viewport().get_camera_2d()
	if Config.current_camera != null:
		Config.zoom = clamp(zoom_value, Config.MIN_ZOOM,  Config.MAX_ZOOM)
		Config.current_camera.zoom = Vector2(1/Config.zoom, 1/Config.zoom)
				

func on_drag(event, drag_position : Vector2) -> void:
	# Drag instruction

	if Config.drag_focus != null:
		# Drag ouput
		if Config.drag_focus is InstructionOutput:
			Config.drag_focus.set_end_position(drag_position)
		else:
			# Drag instruction
			Config.drag_focus.drag(drag_position - Config.drag_offset)
	#Pan move
	else:
		Config.current_camera = get_viewport().get_camera_2d()
		if Config.current_camera != null:
			if Config.is_panning:
				Config.current_camera.position -= event.relative * Config.zoom
				Config.current_camera.update()

func on_left_click(click_position : Vector2) -> void:

	#If click on nothing, unfocus keyboard
	Config.drag_focus = get_schem_at_mouse_position()
	if Config.drag_focus:
		var ins : Instruction = load(instruction[Config.drag_focus.instruction_name]).instantiate()
		ins.global_position = get_global_mouse_position()
		ins.on_content_change.connect(update_live_code.bind())
		ins.add_to_group("Instruction")
		ins.add_to_group("Drag")
		call_deferred("add_child", ins)
		Config.drag_focus = ins
		return
		
	Config.drag_focus = Config.get_node_at_mouse_position("Drag")
	if Config.drag_focus == null:
		if Config.keyboard_focus != null:
			Config.keyboard_focus.unfocus()
		else:
			Config.is_panning = true
	else:
		Config.drag_offset = click_position - Config.drag_focus.get_global_position()
		return
	
func on_left_release():
	if Config.drag_focus is InstructionOutput:
		var target = Config.get_node_at_mouse_position("Input")
			
		if target == null:
			Config.drag_focus.disconnect_instruction()
			Config.drag_focus.reset()
		else:
			Config.drag_focus.connect_instruction(target)
			Config.drag_focus.drop()

	Config.drag_focus = null
	Config.is_panning = false


func update_live_code() -> void:
	var start = get_tree().get_nodes_in_group("Start")
	
	if start != null and start.size() > 0:
		start[0].set_line(0)
		var text = ""
		text += "L   Instruction\n"
		var ins_output = start[0].get_code()
		for i in range(0, ins_output.size()):
			text += str(i) + "   " + ins_output[i] + "\n"
		$EditorUI/LiveCodePanel/Croll/LiveCode.text = text

func get_code() -> void:
	var start = get_tree().get_nodes_in_group("Start")
	
	if start != null and start.size() > 0:
		start[0].set_line(0)
		var text = ""
		var ins_output = start[0].get_code(1)
		for i in range(0, ins_output.size()):
			text += ins_output[i] + "\n"
		DisplayServer.clipboard_set(text)


func _on_get_code_button_down() -> void:
	get_code()

func get_schem_at_mouse_position() -> Instruction:
	if not SCHEMATIC_PANEL.get_global_rect().has_point(SCHEMATIC_PANEL.get_global_mouse_position()):
		return null
	var schematics : Array = get_tree().get_nodes_in_group("SchematicPreview")
	for schematic in schematics:
		var mouse_position = schematic.get_global_mouse_position()
		if schematic.global_position.x > mouse_position.x:
			continue
		if schematic.global_position.y > mouse_position.y:
			continue
		var schematic_end_position = schematic.global_position + schematic.size * schematic.scale
		# Scale to pannel size
		if schematic_end_position.x > (SCHEMATIC_PANEL.global_position + SCHEMATIC_PANEL.size).x:
			schematic_end_position.x = (SCHEMATIC_PANEL.global_position + SCHEMATIC_PANEL.size).x
			
		if schematic_end_position.x < mouse_position.x:
			continue
		if schematic_end_position.y < mouse_position.y:
			continue
		return schematic
	return null
	
