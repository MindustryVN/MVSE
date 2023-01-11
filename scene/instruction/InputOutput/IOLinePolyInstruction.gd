class_name IOLinePolyInstruction
extends Instruction


func setup():
	color = Config.INSTRUCTION_COLOR["INPUT_OUTPUT"]
	add_output("output")
	add_input("input")

	add_component("line4", "BaseLineColor", "row")
	add_component("line2", "BaseLineColor", "row")
	add_component("line3", "BaseLineColor", "row")
	add_component("text6", "CenterLabel", "line4").text = "linePoly"
	add_component("text1", "CenterLabel", "line2").text = "x"
	add_component("x", "TextBox", "line2")
	add_component("text2", "CenterLabel", "line2").text = "y"
	add_component("y", "TextBox", "line2")
	add_component("text3", "CenterLabel", "line2").text = "sides"
	add_component("s", "TextBox", "line2")
	add_component("text4", "CenterLabel", "line3").text = "radius"
	add_component("rad", "TextBox", "line3")
	add_component("text5", "CenterLabel", "line3").text = "rotation"
	add_component("rot", "TextBox", "line3")

func get_content() -> Array:
	var x : String = get_component_value("x", "0")
	var y : String = get_component_value("y", "0")
	var s : String = get_component_value("s", "0")
	var rad : String = get_component_value("rad", "0")
	var rot : String = get_component_value("rot", "0")
	return ["draw linePoly " + x + " " + y + " " + s + " " + rad + " " + rot + " 0"]
