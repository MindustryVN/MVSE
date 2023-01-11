class_name FlowStopInstruction
extends Instruction


func setup():
	color = Config.INSTRUCTION_COLOR["FLOW_CONTROL"]
	add_input("input")
	add_component("line2", "BaseLineColor", "row")

func get_content() -> Array:
	return ["stop"]
