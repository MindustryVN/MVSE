class_name IOColInstruction
extends Instruction


func setup():
	color = Config.INSTRUCTION_COLOR["INPUT_OUTPUT"]
	add_output("output")
	add_input("input")

	add_component("line2", "BaseLineColor", "row")
	add_component("text1", "CenterLabel", "line2").text = "color"
	add_component("color", "TextBox", "line2")

func get_content() -> Array:
	var col : String = get_component_value("color", "0")

	return ["draw col " + col + " 0 0 0 0 0"]
