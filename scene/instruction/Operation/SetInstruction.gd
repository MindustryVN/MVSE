class_name SetInstruction
extends Instruction

func abtr():
	color = Config.INSTRUCTION_COLOR["OPERATIONS"]
	add_input("input")
	add_output("output")

func get_content() -> Array:
	var variable = $BaseRow/BaseLineColor/TextInput.get_content("0")
	var value = $BaseRow/BaseLineColor/TextInput2.get_content("0")
	
	return ["set " + variable + " " + value ]
	
