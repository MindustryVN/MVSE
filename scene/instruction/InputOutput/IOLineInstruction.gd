class_name IOLineInstruction
extends Instruction


func setup():
	color = Config.INSTRUCTION_COLOR["INPUT_OUTPUT"]
	add_output("output")
	add_input("input")

	add_component("line4", "BaseLineColor", "row")
	add_component("line2", "BaseLineColor", "row")
	add_component("line3", "BaseLineColor", "row")
	add_component("text5", "CenterLabel", "line4").text = "line"
	add_component("text1", "CenterLabel", "line2").text = "x"
	add_component("x", "TextBox", "line2")
	add_component("text2", "CenterLabel", "line2").text = "y"
	add_component("y", "TextBox", "line2")
	add_component("text3", "CenterLabel", "line2").text = "x2"
	add_component("x2", "TextBox", "line2")
	add_component("text4", "CenterLabel", "line3").text = "y2"
	add_component("y2", "TextBox", "line3")

func get_content() -> Array:
	var x : String = get_component_value("x", "0")
	var y : String = get_component_value("y", "0")
	var x2 : String = get_component_value("x2", "0")
	var y2 : String = get_component_value("y2", "0")
	return ["draw line " + x + " " + y + " " + x2 + " " + y2 + " 0 0"]
