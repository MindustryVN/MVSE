class_name StopInstruction
extends Instruction

func abtr():
	color = Config.INSTRUCTION_COLOR["FLOW_CONTROL"]
	add_input("input")

func get_content() -> Array:
	return ["stop"]
