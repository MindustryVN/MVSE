class_name LogInstruction
extends Instruction

func abtr():
	color = Config.INSTRUCTION_COLOR["OPERATIONS"]
	add_input("input")
	add_output("output")

func get_content() -> Array:
	var variable = $BaseRow/BaseLineColor/TextInput.get_content("result")
	var value = $BaseRow/BaseLineColor/TextInput2.get_content("0")
	var value2 = $BaseRow/BaseLineColor/TextInput3.get_content("0")
	var value3 = $BaseRow/BaseLineColor/TextInput4.get_content("0")
	var value4 = $BaseRow/BaseLineColor/TextInput5.get_content("0")
	
	return ["op packcolor " + variable + " " + value + " " + value2 + " " + value3 + " " + value4]

	
