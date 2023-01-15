extends Node2D

@onready var FPS_LABEL : Label = $EditorUI/TaskBar/HBoxContainer/Label

@onready var SCHEMATIC_PANEL : PanelContainer = $EditorUI/SchematicPanel
@onready var LIVECODE_PANEL : PanelContainer = $EditorUI/LiveCodePanel 
@onready var LOG_PANEL : PanelContainer = $EditorUI/LogPanel
@onready var TASK_BAR : MenuBar = $EditorUI/TaskBar

@onready var SCHEMATIC_CONTAINER  = $EditorUI/SchematicPanel/VBoxContainer/PanelContainer
@onready var SELECT_RECTANGLE  = $SelectRectangle
@onready var SELECT_RECTANGLE_SIZE = $SelectRectangle/Panel

var instruction_dic : Dictionary = {}
var instruction_ins : Array= []
var instruction_selecting : Array = []

var select_rectangle_size : Vector2= Vector2.ZERO
var touch_position = {}
var last_dist = 0

var exception : Array = [
	StartException.new(),
	InstructionException.new(),
	InstructionLimitException.new()
	]

signal on_instruction_added
signal on_instruction_deleted

func _draw():
	draw_line(Vector2(20000,0), Vector2(-20000,0), Color.GREEN)
	draw_line(Vector2(0,20000), Vector2(0,-20000), Color.GREEN)

func _ready():
	Config.on_content_change.connect(update_live_code.bind())
	Config.on_content_change.connect(check_exception.bind())
	Config.on_content_change.connect(reset_line.bind(get_start_instruction()))
	on_instruction_added.connect(check_exception.bind())
	on_instruction_deleted.connect(check_exception.bind())
	
	get_viewport().size_changed.connect(resize.bind())
	call_deferred("resize")
	
	show_live_code(true)
	show_schematic(true)
	
	for excep in exception:
		LOG_PANEL.add_child(excep)
	
	add_preview_instruction()
	check_exception()

func _process(delta: float) -> void:
	FPS_LABEL.text = "  FPS:"  + str(Engine.get_frames_per_second()) 
	
	if Config.drag_focus != null or Config.is_selecting:
		var local_mouse_pos : Vector2 = get_viewport().get_mouse_position() 
		var viewport_size : Vector2 = get_viewport_rect().size
		if local_mouse_pos.x < Config.START_AUTO_PAN_DISTANCE:
			Config.current_camera.position.x -= Config.AUTO_PAN_SPEED * Config.zoom * delta
		elif local_mouse_pos.x > viewport_size.x - Config.START_AUTO_PAN_DISTANCE:
			Config.current_camera.position.x += Config.AUTO_PAN_SPEED * Config.zoom * delta
		
		if local_mouse_pos.y < Config.START_AUTO_PAN_DISTANCE:
			Config.current_camera.position.y -= Config.AUTO_PAN_SPEED * Config.zoom * delta
		elif local_mouse_pos.y > viewport_size.y - Config.START_AUTO_PAN_DISTANCE:
			Config.current_camera.position.y += Config.AUTO_PAN_SPEED * Config.zoom * delta
	
func _input(event):
	if OS.get_name() == "Android":
		touch_input(event)
		mouse_input(event)
	else:
		mouse_input(event)

func mouse_input(event) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			if event.button_index == MOUSE_BUTTON_LEFT:
				on_click(get_global_mouse_position())
			if event.button_index == MOUSE_BUTTON_RIGHT:
				on_alternative_click(get_global_mouse_position())
				
		else:
			on_release(get_global_mouse_position())
			#Zoom
			
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			on_zoom(Config.zoom / Config.ZOOM_FACTOR)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			on_zoom(Config.zoom * Config.ZOOM_FACTOR)

	elif event is InputEventMouseMotion:
		on_drag(event.relative, get_global_mouse_position())
	
	if event is InputEventKey:
		if event.is_pressed() and event.keycode == KEY_V:
			paste_instruction(get_global_mouse_position())
			
		if event.is_pressed() and event.keycode == KEY_DELETE:
			delete_instruction()

func touch_input(event) -> void:
	if event is InputEventScreenDrag:
		touch_position[event.index] = event.position
		if event.index >= 1:
			var dist = (touch_position[0] - touch_position[1]).length()
			if last_dist == 0:
				last_dist = dist
			on_zoom(Config.zoom - (dist - last_dist) / 1000)
			Config.is_zooming = true
		
func on_alternative_click(click_position : Vector2) -> void:
	# Delete instruction
	var obj = Config.get_node_at_position("Instruction", click_position)
	if obj:
		obj.delete()
		await obj.tree_exited
		on_instruction_deleted.emit()
	else:
		Config.is_selecting = true
		Config.select_start = click_position
		SELECT_RECTANGLE.global_position = click_position
		SELECT_RECTANGLE_SIZE.size = Vector2.ZERO

func on_zoom(zoom_value : float) -> void:
	Config.current_camera = get_viewport().get_camera_2d()
	if Config.current_camera != null:
		Config.zoom = clamp(zoom_value, Config.MIN_ZOOM,  Config.MAX_ZOOM)
		Config.current_camera.zoom = Vector2(1/Config.zoom, 1/Config.zoom)
				

func on_drag(drag_relative : Vector2, drag_position : Vector2) -> void:
	LIVECODE_PANEL.on_drag()
	SCHEMATIC_PANEL.on_drag()
	LOG_PANEL.on_drag()
	
	if Config.is_resizing:
		return
	
	if Config.is_zooming:
		return
	
	if Config.is_selecting:
		var select_rectangle_position = Vector2(min(Config.select_start.x, drag_position.x),min(Config.select_start.y, drag_position.y) )
		SELECT_RECTANGLE.global_position = Vector2(select_rectangle_position)
		SELECT_RECTANGLE_SIZE.size = Vector2(abs(Config.select_start.x - drag_position.x),abs(Config.select_start.y - drag_position.y))
		return
		
	if Config.is_scrolling:
		var front = instruction_ins.front()
		var back = instruction_ins.back()
		var screen_size = get_viewport_rect().size
		if front == null or back == null:
			return 
		if front.global_position.y + drag_relative.y + Config.COMPONENT_SPACE_Y < 0:
			if drag_relative.y > 0:
				for i in instruction_ins:
					i.position.y += drag_relative.y
				
		if back.global_position.y + back.get_size().y + Config.COMPONENT_SPACE_Y + drag_relative.y > screen_size.y:
			if drag_relative.y < 0:
				for i in instruction_ins:
					i.position.y += drag_relative.y

	# Drag instruction
	if Config.drag_focus != null:
		# Drag ouput
		if Config.drag_focus is InstructionOutput:
			Config.drag_focus.on_drag(drag_position)
		else:
			# Drag instruction
			Config.drag_focus.drag(drag_position - Config.drag_offset)
	#Pan move
	else:
		Config.current_camera = get_viewport().get_camera_2d()
		if Config.current_camera != null:
			if Config.is_panning:
				Config.current_camera.position -= drag_relative * Config.zoom
				Config.current_camera.update()

func on_click(click_position : Vector2) -> void:
	
	LIVECODE_PANEL.on_click()
	SCHEMATIC_PANEL.on_click()
	LOG_PANEL.on_click()
	
	if Config.start_select:
		Config.is_selecting = true
		Config.select_start = click_position
		SELECT_RECTANGLE.global_position = get_global_mouse_position()
		SELECT_RECTANGLE_SIZE.size = Vector2.ZERO
		Config.start_select = false
		return
		
	if Config.start_paste:
		paste_instruction(get_global_mouse_position())
		Config.start_paste = false
		
	if Config.is_resizing:
		return
	
	for excep in exception:
		if excep.on_click(excep.get_global_mouse_position()):
			return
	#If click on nothing, unfocus keyboard
	if SCHEMATIC_CONTAINER.get_global_rect().has_point(SCHEMATIC_CONTAINER.get_global_mouse_position()):
		Config.drag_focus = get_schematic(click_position)
		if Config.drag_focus:
			Config.drag_focus = await add_instruction(Config.drag_focus.instruction_name)
			return
			
	if SCHEMATIC_PANEL.get_global_rect().has_point(SCHEMATIC_PANEL.get_global_mouse_position()):
		Config.is_scrolling = true
		return
	
	Config.drag_focus = Config.get_node_at_position("Drag", click_position)
	if Config.drag_focus == null:
		if Config.keyboard_focus != null:
			Config.keyboard_focus.unfocus()
		else:
			Config.is_panning = true
	else:
		Config.drag_offset = click_position - Config.drag_focus.get_global_position()
		return
	
func on_release(release_position : Vector2):
	LIVECODE_PANEL.on_release()
	SCHEMATIC_PANEL.on_release()
	LOG_PANEL.on_release()
	
	if is_instance_valid(Config.drag_focus):
		if Config.drag_focus is InstructionOutput:
			var target = Config.get_node_at_position("Input", release_position)
			
			if target == null:
				Config.drag_focus.disconnect_instruction()
				Config.drag_focus.reset()
			else:
				Config.drag_focus.connect_instruction(target)
	
	if not Config.drag_focus == null:
		if Config.drag_focus.has_method("drop"):
			Config.drag_focus.drop()
			
	if Config.is_selecting:
		if release_position == Config.select_start:
			SELECT_RECTANGLE.global_position = Vector2(Config.MAX_WORLD_SIZE,Config.MAX_WORLD_SIZE) * 2 # Outside world so user can't see it
		else:
			select_instruction(Config.select_start, release_position)
		
	Config.is_selecting = false
	Config.is_panning = false
	Config.is_scrolling = false
	Config.drag_focus = null
	Config.is_zooming = false
	last_dist = 0
	
func select_instruction(start : Vector2, end : Vector2):
	instruction_selecting = Config.get_node_in_rect("Instruction", start, end)

func paste_instruction(paste_position : Vector2):
	if instruction_selecting.size() == 0:
		return
	var result : Dictionary = {}
	var target_iid : int = -1
	var start_position : Vector2 = instruction_selecting[0].global_position
	var ins : Instruction
	var current_ins : Instruction
	var target_ins : Instruction
	
	for i in instruction_selecting:
		ins = await add_instruction(i.instruction_name)
		if ins == null:
			return
		result[i.iid] = ins
		ins.global_position = paste_position - start_position + i.global_position

	await get_tree().process_frame
	for i in instruction_selecting:
		current_ins = result[i.iid]
		for key in i.output.keys():
			target_iid = i.output[key].get_target_iid()
			if target_iid == -1:
				continue
			if not result.has(target_iid):
				continue
			target_ins = result[target_iid]
			if result.has(target_iid):
				var target_input : String = i.output[key].get_target_name()
				current_ins.output[key].connect_instruction(target_ins.input[target_input])

func delete_instruction():
	for i in instruction_selecting:
		i.delete()
		await i.tree_exited
	on_instruction_deleted.emit()

func add_preview_instruction():
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
			elif not file.begins_with(".") and file.ends_with(".gd"):
				instruction_dic[file.replace(".gd", "").replace("Instruction", "")] = path + "/" + file
				
		dir.list_dir_end()
	
	
	var start = Vector2(Config.IO_CIRCLE_RADIUS * 2, 0)
	
	
	for ins_name in instruction_dic.keys():
		var ins : Instruction = load(instruction_dic[ins_name]).new(ins_name)
		instruction_ins.append(ins)
		ins.global_position = start
		ins.add_to_group("SchematicPreview")
		ins.name = ins_name
		ins.instruction_name = ins_name
		ins.scale = Vector2(Config.EDITOR_SCHEMATIC_SCALE,Config.EDITOR_SCHEMATIC_SCALE)
		SCHEMATIC_CONTAINER.call_deferred("add_child", ins)
		await ins.on_ready
		ins.set_disable(true)
		start.y += (ins.get_size().y + Config.COMPONENT_SPACE_Y) * Config.EDITOR_SCHEMATIC_SCALE
		
		
		
func resize():
	var view : Rect2 = get_viewport_rect()
	if OS.get_name() == "Android":
		Config.TOOL_BAR_HEIGHT *= 3
	TASK_BAR.position = Vector2.ZERO
	TASK_BAR.size = Vector2(view.size.x, Config.TOOL_BAR_HEIGHT)
	
	LIVECODE_PANEL.position = Vector2(view.size.x - LIVECODE_PANEL.size.x, TASK_BAR.size.y)
	LIVECODE_PANEL.size.y = view.size.y - TASK_BAR.size.y
	
	SCHEMATIC_PANEL.position = Vector2(0, TASK_BAR.size.y)
	SCHEMATIC_PANEL.size.y =  view.size.y - TASK_BAR.size.y
	
	LOG_PANEL.on_resize()
	
func show_live_code(value : bool):
	LIVECODE_PANEL.visible = value
	
func show_schematic(value : bool):
	SCHEMATIC_PANEL.visible = value
	
func add_instruction(instruction_name : String) -> Instruction:
	if get_tree().get_nodes_in_group("Instruction").size() > 1000:
		return
	var ins : Instruction = load(instruction_dic[instruction_name]).new(instruction_name)
	call_deferred("add_child", ins)
	ins.add_to_group("Instruction")
	ins.add_to_group("Drag")
	ins.iid = Config.getIID()
	ins.global_position = get_global_mouse_position()
	await ins.on_ready
	on_instruction_added.emit()
	return ins

func update_live_code() -> void:
	if not LIVECODE_PANEL.visible:
		return
	var code = get_code()
	var text = "L    Instruction\n"
	for i in range(0, code.size()):
		text += str(i) + "   " + code[i] + "\n"
	$EditorUI/LiveCodePanel/Croll/LiveCode.text = text

func set_line(start : FlowStartInstruction) -> void:
	Config.current_line = Config.START_LINE
	start.set_line()

func reset_line(start : FlowStartInstruction) -> void:
	Config.current_line = Config.START_LINE
	for ins in get_tree().get_nodes_in_group("Instruction"):
		ins.reset_line()
	if is_instance_valid(start):
		set_line(start)

func get_code() -> Array:
	var start : FlowStartInstruction = get_start_instruction()
	if is_instance_valid(start):
		reset_line(start)
		var ins_output = start.get_code()
		if ins_output.back() == "end":
			ins_output.pop_back()
		return ins_output
	return [""]

func get_start_instruction() -> FlowStartInstruction:
	var start = get_tree().get_nodes_in_group("Start")
	for s in start:
		if not s.is_in_group("SchematicPreview"):
			return s
	return null

func _on_get_code_button_down() -> void:
	var code = get_code()
	var text = ""
	for i in range(0, code.size()):
		text += code[i] + "\n"
		DisplayServer.clipboard_set(text)

func get_schematic(click_position : Vector2) -> Instruction:
	if not SCHEMATIC_PANEL.get_global_rect().has_point(SCHEMATIC_PANEL.get_global_mouse_position()):
		return null
	return Config.get_node_at_position("SchematicPreview", get_viewport_transform() * click_position)
	


func _on_search_box_text_changed(new_text: String) -> void:
	new_text = new_text.to_lower()
	var result : Array = []
	var instruction : Array = get_tree().get_nodes_in_group("SchematicPreview")
	for i in instruction:
		i.global_position.x = Config.MAX_WORLD_SIZE * 2 # Outside world so user can't see it
		i.hide()
		if i.instruction_name.to_lower().begins_with(new_text):
			if result.has(i):
				continue
			result.append(i)

	if result.size() <= 10:
		for i in instruction:
			if not i.instruction_name.to_lower().contains(new_text):
				continue
			if result.has(i):
				continue
			result.append(i)
	
	instruction_ins = result
	if result.size() == 0:
		return
	var start = Vector2(Config.IO_CIRCLE_RADIUS * 2, SCHEMATIC_CONTAINER.global_position.y)
	for i in instruction_ins:
		i.global_position = start
		i.show()
		start.y += (i.get_size().y + Config.COMPONENT_SPACE_Y) * Config.EDITOR_SCHEMATIC_SCALE 

func check_exception() -> void:
	for excep in exception:
		excep.check()
		
