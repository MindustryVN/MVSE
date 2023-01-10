class_name LineInstruction
extends Instruction

func abtr():
	color = Config.INSTRUCTION_COLOR["INPUT_OUTPUT"]
	add_output("output")
	add_input("input")
	


func get_content() -> Array:
	var r : String = $BaseRow/BaseLineColor/TextInput.get_content("0")
	
	return ["draw stroke " + r + " 0 0 0 0 0 0"]
