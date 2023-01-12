class_name UnitMoveInstruction
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



func get_content() -> Array:
	var x : String = get_component_value("x", "0")
	var y : String = get_component_value("y", "0")
	
	return ["ucontrol move " + x + " " + y + " 0 0 0"]

