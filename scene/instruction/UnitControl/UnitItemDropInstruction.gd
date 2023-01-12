class_name UnitItemDropInstruction
extends Instruction


func setup():
	color = Config.INSTRUCTION_COLOR["UNIT_CONTROL"]
	add_output("output")
	add_input("input")
	add_component("line2", "BaseLineColor", "row")
	add_component("text2", "CenterLabel", "line2").text = "to"
	add_component("to", "TextBox", "line2")
	add_component("text3", "CenterLabel", "line2").text = "amount"
	add_component("amount", "TextBox", "line2")

func get_content() -> Array:
	var to : String = get_component_value("to", "0")
	var amount : String = get_component_value("amount", "0")

	return ["ucontrol itemDrop " + to + " " + amount + " 0 0 0"]

