class_name ControlConfigInstruction
extends Instruction


func setup():
	color = Config.INSTRUCTION_COLOR["BLOCK_CONTROL"]
	add_output("output")
	add_input("input")
	add_component("line2", "BaseLineColor", "row")
	add_component("text1", "CenterLabel", "line2").text = "set config of"
	add_component("block", "TextBox", "line2")
	add_component("text2", "CenterLabel", "line2").text = "to"
	add_component("config", "TextBox", "line2")

func get_content() -> Array:
	var block : String = get_component_value("block","block1")
	var config : String = get_component_value("config","0")
	
	return ["control config " + block + " " + config + " 0 0 0"]
