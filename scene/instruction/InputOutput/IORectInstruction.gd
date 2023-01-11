class_name IORectInstruction
extends Instruction


func setup():
	color = Config.INSTRUCTION_COLOR["INPUT_OUTPUT"]
	add_output("output")
	add_input("input")

	add_component("line4", "BaseLineColor", "row")
	add_component("line2", "BaseLineColor", "row")
	add_component("line3", "BaseLineColor", "row")
	add_component("text5", "CenterLabel", "line4").text = "rect"
	add_component("text1", "CenterLabel", "line2").text = "x"
	add_component("x", "TextBox", "line2")
	add_component("text2", "CenterLabel", "line2").text = "y"
	add_component("y", "TextBox", "line2")
	add_component("text3", "CenterLabel", "line3").text = "width"
	add_component("w", "TextBox", "line3")
	add_component("text4", "CenterLabel", "line3").text = "height"
	add_component("h", "TextBox", "line3")

func get_content() -> Array:
	var x : String = get_component_value("x", "0")
	var y : String = get_component_value("y", "0")
	var w : String = get_component_value("w", "0")
	var h : String = get_component_value("h", "0")
	return ["draw rect " + x + " " + y + " " + w + " " + h + " 0 0"]
