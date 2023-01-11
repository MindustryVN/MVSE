class_name ControlColorInstruction
extends Instruction


func setup():
	color = Config.INSTRUCTION_COLOR["BLOCK_CONTROL"]
	add_output("output")
	add_input("input")
	add_component("line2", "BaseLineColor", "row")
	add_component("text1", "CenterLabel", "line2").text = "set color of"
	add_component("block", "TextBox", "line2")
	add_component("text2", "CenterLabel", "line2").text = "to"
	add_component("value", "TextBox", "line2")

func get_content() -> Array:
	var block : String = get_component_value("block","block1")
	var value : String = get_component_value("value","0")

	return ["control color " + block + " " + value + " 0 0 0 0"]
