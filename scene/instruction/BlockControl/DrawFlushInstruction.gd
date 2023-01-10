class_name DrawFlushInstruction
extends Instruction

func abtr():
	color = Config.INSTRUCTION_COLOR["INPUT_OUTPUT"]
	add_output("output")
	add_input("input")

func get_content() -> Array:
	var to : String = $BaseRow/BaseLineColor/TextInput.get_content("display1")

	return ["drawflush " + to]

