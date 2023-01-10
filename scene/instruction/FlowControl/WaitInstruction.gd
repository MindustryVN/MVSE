class_name WaitInstruction
extends Instruction

func abtr():
	color = Config.INSTRUCTION_COLOR["FLOW_CONTROL"]
	add_output("output")
	add_input("input")

func get_content() -> Array:
	var sec : String = $BaseRow/BaseLineColor/TextInput.get_content("0")
	return ["wait " + sec]
