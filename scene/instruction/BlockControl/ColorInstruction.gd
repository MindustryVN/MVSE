class_name ControlColorInstruction
extends Instruction

func abtr():
	color = Config.INSTRUCTION_COLOR["BLOCK_CONTROL"]
	add_output("output")
	add_input("input")

func get_content() -> Array:
	var block : String = $BaseRow/BaseLineColor/TextInput.get_content("block1")
	var value : String = $BaseRow/BaseLineColor/TextInput2.get_content("0")

	return ["control color " + block + " " + value + " 0 0 0 0"]
