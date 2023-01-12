class_name UnitItemTakeInstruction
extends Instruction


func setup():
	color = Config.INSTRUCTION_COLOR["UNIT_CONTROL"]
	add_output("output")
	add_input("input")
	add_component("line2", "BaseLineColor", "row")
	add_component("text2", "CenterLabel", "line2").text = "from"
	add_component("from", "TextBox", "line2")
	add_component("text5", "CenterLabel", "line2").text = "item"
	add_component("item", "TextBox", "line2")
	add_component("text3", "CenterLabel", "line2").text = "amount"
	add_component("amount", "TextBox", "line2")

func get_content() -> Array:
	var from : String = get_component_value("from", "0")
	var item : String = get_component_value("item", "0")
	var amount : String = get_component_value("amount", "0")

	return ["ucontrol itemTake " + from + " " + item + " " + amount + " 0 0"]

