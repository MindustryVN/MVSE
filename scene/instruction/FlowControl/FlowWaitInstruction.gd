class_name FlowWaitInstruction
extends Instruction


func setup():
	color = Config.INSTRUCTION_COLOR["FLOW_CONTROL"]
	add_output("output")
	add_input("input")
	add_component("line2", "BaseLineColor", "row")
	add_component("sec", "TextBox", "line2")
	add_component("text1", "CenterLabel", "line2").text = "sec"

func get_content() -> Array:
	return ["wait " + get_component_value("sec", "0.5")]

