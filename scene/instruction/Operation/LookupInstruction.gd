class_name LookupInstruction
extends Instruction

func abtr():
	color = Config.INSTRUCTION_COLOR["OPERATIONS"]
	add_input("input")
	add_output("output")

func get_content() -> Array:
	var variable = $BaseRow/BaseLineColor/TextInput.get_content("result")
	var cat = $BaseRow/BaseLineColor/TextInput2.get_content("item")
	var pos = $BaseRow/BaseLineColor/TextInput3.get_content("0")
	
	return ["op lookup " + variable + " " + cat + " " + pos ]

	
