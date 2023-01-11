class_name ControlShootpInstruction
extends Instruction


func setup():
	color = Config.INSTRUCTION_COLOR["BLOCK_CONTROL"]
	add_output("output")
	add_input("input")
	add_component("line2", "BaseLineColor", "row")
	add_component("line3", "BaseLineColor", "row")
	add_component("text1", "CenterLabel", "line2").text = "set shootp of"
	add_component("block", "TextBox", "line2")
	add_component("text2", "CenterLabel", "line3").text = "unit"
	add_component("unit", "TextBox", "line3")
	add_component("text4", "CenterLabel", "line3").text = "shoot"
	add_component("shoot", "TextBox", "line3")

func get_content() -> Array:
	var block : String = get_component_value("block","block1")
	var unit : String = get_component_value("unit","0")
	var shoot : String = get_component_value("shoot","0")

	return ["control shootp " + block + " " + unit + " " + shoot + " 0 0"]

