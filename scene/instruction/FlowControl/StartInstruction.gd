class_name StartInstruction
extends Instruction



func abtr():
	has_input = false
	color = Config.INSTRUCTION_COLOR["FLOW_CONTROL"]
	add_output("output")
	add_to_group("Start")
	
