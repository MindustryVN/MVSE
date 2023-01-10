class_name XorInstruction
extends Instruction

func abtr():
	color = Config.INSTRUCTION_COLOR["OPERATIONS"]
	add_input("input")
	add_output("output")

func get_content() -> Array:
	var variable = $BaseRow/BaseLineColor/TextInput.get_content("result")
	var value = $BaseRow/BaseLineColor/TextInput2.get_content("a")
	var value2 = $BaseRow/BaseLineColor/TextInput3.get_content("b")
	
	return ["op xor " + variable + " " + value + " " + value2 ]

	
