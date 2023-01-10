class_name GetLinkInstruction
extends Instruction

func abtr():
	color = Config.INSTRUCTION_COLOR["BLOCK_CONTROL"]
	add_input("input")
	add_output("output")

func get_content() -> Array:
	var variable = $BaseRow/BaseLineColor/TextInput.get_content("result")
	var value = $BaseRow/BaseLineColor/TextInput2.get_content("0")
	
	return ["getlink " + variable + " " + value]

	
