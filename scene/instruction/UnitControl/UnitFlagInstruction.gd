class_name UnitFlagInstruction
extends Instruction


func setup():
	color = Config.INSTRUCTION_COLOR["UNIT_CONTROL"]
	add_output("output")
	add_input("input")
	add_component("line2", "BaseLineColor", "row")
	add_component("text2", "CenterLabel", "line2").text = "enable"
	add_component("e", "TextBox", "line2")



func get_content() -> Array:
	var e : String = get_component_value("e", "0")
	
	return ["ucontrol flag " + e + " 0 0 0 0"]

