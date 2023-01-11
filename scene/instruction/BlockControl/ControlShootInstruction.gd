class_name ControlShootInstruction
extends Instruction


func setup():
	color = Config.INSTRUCTION_COLOR["BLOCK_CONTROL"]
	add_output("output")
	add_input("input")
	add_component("line2", "BaseLineColor", "row")
	add_component("line3", "BaseLineColor", "row")
	add_component("text1", "CenterLabel", "line2").text = "set shoot of"
	add_component("block", "TextBox", "line2")
	add_component("text2", "CenterLabel", "line2").text = "x"
	add_component("x", "TextBox", "line2")
	add_component("text3", "CenterLabel", "line3").text = "y"
	add_component("y", "TextBox", "line3")
	add_component("text4", "CenterLabel", "line3").text = "shoot"
	add_component("shoot", "TextBox", "line3")

func get_content() -> Array:
	var block : String = get_component_value("block","block1")
	var x : String = get_component_value("x","0")
	var y : String = get_component_value("y","0")
	var shoot : String = get_component_value("shoot","0")

	return ["control shoot " + block + " " + x + " " + y + " " + shoot]
