class_name IOReadInstruction
extends Instruction


func setup():
	color = Config.INSTRUCTION_COLOR["INPUT_OUTPUT"]
	add_output("output")
	add_input("input")

	add_component("line2", "BaseLineColor", "row")
	add_component("line3", "BaseLineColor", "row")
	add_component("text1", "CenterLabel", "line2").text = "read"
	add_component("result", "TextBox", "line2")
	add_component("text2", "CenterLabel", "line2").text = "="
	add_component("block", "TextBox", "line2")
	add_component("text3", "CenterLabel", "line3").text = "at"
	add_component("at", "TextBox", "line3")

func get_content() -> Array:
	var result : String = get_component_value("result", "result")
	var block : String = get_component_value("block", "cell1")
	var at : String = get_component_value("at", "0")
	return ["read " + result + " " + block + " " + at]
