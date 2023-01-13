extends Node2D

# Global constant

const START_LINE = -1


const INSTRUCTION_COLOR = {
	OPERATIONS = Color("877bad"),
	INPUT_OUTPUT = Color("a08a8a"),
	BLOCK_CONTROL = Color("d4816b"),
	FLOW_CONTROL = Color("6bb2b2"),
	UNIT_CONTROL = Color("c7b59d")
}

const LOCATE_GROUP = ["core", "storage", "generator", "turret", "factory", "repair", "battery", "reactor"]

const COMPONENT_TYPE = {
	"InstructionBackground" = "res://scene/instruction/Base/InstructionBackground.tscn",
	"BaseLine" = "res://scene/instruction/Base/BaseLine.tscn",
	"BaseLineColor" = "res://scene/instruction/Base/BaseLineColor.tscn",
	"BaseRow" = "res://scene/instruction/Base/BaseRow.tscn",
	"CenterLabel" = "res://scene/instruction/Base/CenterLabel.tscn",
	"ColorLabel" = "res://scene/instruction/Base/ColorLabel.tscn",
	"SelectBox" = "res://scene/instruction/Base/SelectBox.tscn",
	"TextBox" = "res://scene/instruction/Base/Textbox.tscn",
	"LongTextBox" = "res://scene/instruction/Base/LongTextBox.tscn"
}

const OPERATIONS = ["==", "not", "===", ">", ">=", "<" , "<="]

const ITEMS = {"@copper" = "res://asset/item/item-copper.png",
"@lead" = "res://asset/item/item-lead.png",
"@metaglass" = "res://asset/item/item-metaglass.png",
"@graphite" = "res://asset/item/item-graphite.png",
"@sand" = "res://asset/item/item-sand.png",
"@coal" = "res://asset/item/item-coal.png",
"@titanium" = "res://asset/item/item-titanium.png",
"@thorium" = "res://asset/item/item-thorium.png",
"@scrap" = "res://asset/item/item-scrap.png",
"@silicon" = "res://asset/item/item-silicon.png",
"@plastanium" = "res://asset/item/item-plastanium.png",
"@phase-fabric" = "res://asset/item/item-phase-fabric.png",
"@surge-alloy" = "res://asset/item/item-surge-alloy.png",
"@spore-pod" = "res://asset/item/item-spore-pod.png",
"@blast-compound" = "res://asset/item/item-blast-compound.png",
"@pyratite" = "res://asset/item/item-pyratite.png", 
"@beryllium" = "res://asset/item/item-beryllium.png",
"@tungsten" = "res://asset/item/item-tungsten.png",
"@oxide" = "res://asset/item/item-oxide.png",
"@carbide" = "res://asset/item/item-carbide.png"}

const LIQUIDS = {"@water" = "res://asset/item/liquid-water.png",
"@slag" = "res://asset/item/liquid-slag.png",
"@oil" = "res://asset/item/liquid-oil.png",
"@cryofluid" = "res://asset/item/liquid-cryofluid.png",
"@arkycite" = "res://asset/item/liquid-arkycite.png",
"@gallium" = "res://asset/item/liquid-gallium.png",
"@neoplasm" = "res://asset/item/liquid-neoplasm.png",
"@ozone" = "res://asset/item/liquid-ozone.png",
"@hydrogen" = "res://asset/item/liquid-hydrogen.png",
"@nitrogen" = "res://asset/item/liquid-nitrogen.png",
"@cyanogen" = "res://asset/item/liquid-cyanogen.png"}

const TARGET_TYPES = ["any", "enemy", "player", "ally", "attacker", "flying", "ground", "boss"]
const SORT_TYPES = ["distance", "health", "shield", "armor", "maxHealth"]

# Global variable
var current_camera : Camera2D = null

var drag_offset : Vector2 = Vector2.ZERO
var drag_focus = null
var keyboard_focus = null
var is_panning : bool = false
var is_resizing : bool = false
var is_scrolling : bool = false
var is_selecting : bool = false
var select_start : Vector2

var zoom : float = 1
var mutex = Mutex.new()

var current_line = -1
var iid : int = 0

#Config
var UI_SCALE = 1.0

var BASE_HEIGHT : float = 70 * UI_SCALE
var BASE_WIDTH : float = 500 * UI_SCALE

var BASE_MIN_HEIGHT : float = 20 * UI_SCALE
var BASE_MIN_WIDTH : float = 200 * UI_SCALE

var TEXT_BOX_HEIGHT : float = 40 * UI_SCALE
var TEXT_BOX_WIDTH : float = 100 * UI_SCALE

var COMPONENT_SPACE_X : float = 4 * UI_SCALE
var COMPONENT_SPACE_Y : float = 4 * UI_SCALE

var IO_CIRCLE_RADIUS : float = 15 * UI_SCALE
var IO_CIRCLE_COLOR : Color = Color.WHITE

var MAX_ZOOM : float = 5
var MIN_ZOOM : float = 1 

var ZOOM_FACTOR : float = 1.1
var CONNECTION_SEGMENT : float = 50

var MAX_LIVE_CODE_SIZE : float = 0.5
var MIN_LIVE_CODE_SIZE : float = 0.05

var MAX_WORLD_SIZE : float = 8000

var TOOL_BAR_HEIGHT : float = 20 * UI_SCALE

var EDITOR_FONT_SIZE : int = 12 * UI_SCALE
var EDITOR_SCHEMATIC_SCALE = 0.75 * UI_SCALE

var PANEL_BORDER_SIZE : int = 5 * UI_SCALE
var PANEL_BORDER_COLOR : Color = Color.MEDIUM_PURPLE
var PANEL_BACKGROUND_COLOR : Color = Color(0,0,0,0)

signal on_content_change

func get_node_at_position(node_group : String, node_position : Vector2):
	var obj = null
	var node = get_tree().get_nodes_in_group(node_group)
	var i : int = node.size() - 1
	while(i >= 0):
		obj = node[i]
		if obj.visible:
			if obj.on_click(node_position):
				return obj
		i -= 1
	return null

func get_node_in_rect(node_group : String, start_position : Vector2, end_position : Vector2):
	var obj = null
	var start = Vector2(min(start_position.x, end_position.x), min(start_position.y, end_position.y))
	var end = Vector2(max(start_position.x, end_position.x), max(start_position.y, end_position.y))
	var node = get_tree().get_nodes_in_group(node_group)
	var i : int = node.size() - 1
	var result : Array = []
	while(i >= 0):
		obj = node[i]
		if obj.visible:
			if is_inside(obj, start, end):
				result.append(obj)
		i -= 1
	return result

func is_inside(obj : Object, start_position : Vector2, end_position : Vector2):
	if obj.global_position.x >= start_position.x and obj.global_position.x <= end_position.x and obj.global_position.y >= start_position.y and obj.global_position.y <= end_position.y:
		return true
	if obj.global_position.x + obj.get_size().x < start_position.x or obj.global_position.x + obj.get_size().x > end_position.x:
		return false
	if obj.global_position.y + obj.get_size().y < start_position.y or obj.global_position.y + obj.get_size().y > end_position.y:
		return false
	return true
	
	
func is_instruction_component(ob) -> bool:
	if ob.has_method("is_instruction"):
		return ob.is_instruction()
	return false

func getIID() -> int:
	mutex.lock()
	iid += 1
	mutex.unlock()
	return iid 
