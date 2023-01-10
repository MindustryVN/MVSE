class_name PrintInstruction
extends Instruction

func abtr():
	color = Config.INSTRUCTION_COLOR["INPUT_OUTPUT"]
	add_output("output")
	add_input("input")

func get_content() -> Array:
	return ["print " + $BaseRow/BaseLineColor/LongTextInput.get_content("Frog???") ]
