class_name ControlGetLinkInstruction
extends Instruction


func setup():
	color = Config.INSTRUCTION_COLOR["BLOCK_CONTROL"]
	add_output("output")
	add_input("input")
	add_component("line2", "BaseLineColor", "row")
	add_component("variable", "TextBox", "line2")
	add_component("text2", "CenterLabel", "line2").text = "link#"
	add_component("position", "TextBox", "line2")

func get_content() -> Array:
	var variable : String = get_component_value("variable","result")
	var pos : String = get_component_value("position","0")

	return ["getlink " + variable + " " + pos]
