class_name IOImageInstruction
extends Instruction


func setup():
	color = Config.INSTRUCTION_COLOR["INPUT_OUTPUT"]
	add_output("output")
	add_input("input")

	add_component("line2", "BaseLineColor", "row")
	add_component("line3", "BaseLineColor", "row")
	add_component("line5", "BaseLineColor", "row")

	add_component("text1", "CenterLabel", "line2").text = "x"
	add_component("x", "TextBox", "line2")
	add_component("text2", "CenterLabel", "line2").text = "y"
	add_component("y", "TextBox", "line2")
	add_component("text3", "CenterLabel", "line3").text = "image"
	add_component("image", "TextBox", "line3")
	add_component("text4", "CenterLabel", "line3").text = "size"
	add_component("size", "TextBox", "line3")
	add_component("text5", "CenterLabel", "line5").text = "rotation"
	add_component("rot", "TextBox", "line5")

func get_content() -> Array:
	var x : String = get_component_value("x", "0")
	var y : String = get_component_value("y", "0")
	var image : String = get_component_value("image", "@ohno")
	var si : String = get_component_value("size", "32")
	var rot : String = get_component_value("rot", "0")
	return ["draw poly " + x + " " + y + " " + image + " " + si + " " + rot + " 0"]
