class_name PrintFlushInstruction
extends Instruction

func abtr():
	color = Config.INSTRUCTION_COLOR["BLOCK_CONTROL"]
	add_output("output")
	add_input("input")

func get_content() -> Array:
	var to : String = $BaseRow/BaseLineColor/TextInput.get_content("display1")

	return ["printflush " + to]

