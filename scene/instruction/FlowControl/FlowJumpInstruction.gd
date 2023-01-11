class_name FlowJumpInstruction
extends Instruction


func setup():
	color = Config.INSTRUCTION_COLOR["FLOW_CONTROL"]
	add_output("false")
	add_output("true")
	add_input("input")
	add_component("line2", "BaseLineColor", "row")
	add_component("text1", "CenterLabel", "line2").text = "if"
	add_component("x", "TextBox", "line2")
	add_component("op", "SelectBox", "line2").add_options(Config.OPERATIONS)
	add_component("y", "TextBox", "line2")

func get_content() -> Array:
	return ["jump " + " " + str(output["true"].get_line()) + " " + get_component_value("op", "not") + " " + get_component_value("x", "x") + " " + get_component_value("y", "false")]
