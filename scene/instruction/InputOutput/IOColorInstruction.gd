class_name IOColorInstruction
extends Instruction


func setup():
	color = Config.INSTRUCTION_COLOR["INPUT_OUTPUT"]
	add_output("output")
	add_input("input")

	add_component("line2", "BaseLineColor", "row")
	add_component("line3", "BaseLineColor", "row")
	add_component("text1", "CenterLabel", "line2").text = "r"
	add_component("r", "TextBox", "line2")
	add_component("text2", "CenterLabel", "line2").text = "g"
	add_component("g", "TextBox", "line2")
	add_component("text3", "CenterLabel", "line2").text = "b"
	add_component("b", "TextBox", "line2")
	add_component("text4", "CenterLabel", "line3").text = "a"
	add_component("a", "TextBox", "line3")

func get_content() -> Array:
	var r : String = get_component_value("r", "0")
	var g : String = get_component_value("g", "0")
	var b : String = get_component_value("b", "0")
	var a : String = get_component_value("a", "0")
	return ["draw color " + r + " " + g + " " + b + " " + a + " 0 0"]
