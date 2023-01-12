class_name UnitGetBlockInstruction
extends Instruction


func setup():
	color = Config.INSTRUCTION_COLOR["UNIT_CONTROL"]
	add_output("output")
	add_input("input")

	add_component("line2", "BaseLineColor", "row")
	add_component("line3", "BaseLineColor", "row")
	add_component("line5", "BaseLineColor", "row")
	add_component("text1", "CenterLabel", "line2").text = "x"
	add_component("x", "TextBox", "line2")
	add_component("text2", "CenterLabel", "line2").text = "y"
	add_component("y", "TextBox", "line2")
	add_component("text3", "CenterLabel", "line3").text = "type"
	add_component("type", "TextBox", "line3")
	add_component("text5", "CenterLabel", "line3").text = "building"
	add_component("building", "TextBox", "line3")
	add_component("text4", "CenterLabel", "line5").text = "floor"
	add_component("floor", "TextBox", "line5")

func get_content() -> Array:
	var x : String = get_component_value("x", "0")
	var y : String = get_component_value("y", "0")
	var type : String = get_component_value("type", "0")
	var building : String = get_component_value("building", "0")
	var f : String = get_component_value("rot", "0")
	return ["ucontrol getBlock " + x + " " + y + " " + type + " " + building + " " + f]
