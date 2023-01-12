class_name UnitTargetInstruction
extends Instruction


func setup():
	color = Config.INSTRUCTION_COLOR["UNIT_CONTROL"]
	add_output("output")
	add_input("input")
	add_component("line2", "BaseLineColor", "row")
	add_component("text2", "CenterLabel", "line2").text = "x"
	add_component("x", "TextBox", "line2")
	add_component("text3", "CenterLabel", "line2").text = "y"
	add_component("y", "TextBox", "line2")
	add_component("text4", "CenterLabel", "line2").text = "shoot"
	add_component("s", "TextBox", "line2")

func get_content() -> Array:
	var x : String = get_component_value("x", "0")
	var y : String = get_component_value("y", "0")
	var s : String = get_component_value("s", "0")
	
	return ["ucontrol target " + x + " " + y + " " + s + " 0 0"]

