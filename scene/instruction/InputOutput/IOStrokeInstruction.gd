class_name IOStrokeInstruction
extends Instruction


func setup():
	color = Config.INSTRUCTION_COLOR["INPUT_OUTPUT"]
	add_output("output")
	add_input("input")

	add_component("line2", "BaseLineColor", "row")
	add_component("text1", "CenterLabel", "line2").text = "stroke"
	add_component("stroke", "TextBox", "line2")

func get_content() -> Array:
	var stroke : String = get_component_value("stroke", "0")

	return ["draw stroke " + stroke + " 0 0 0 0 0"]
