class_name WriteInstruction
extends Instruction

func abtr():
	color = Config.INSTRUCTION_COLOR["INPUT_OUTPUT"]
	add_output("output")
	add_input("input")
	


func get_content() -> Array:
	var r : String = $BaseRow/BaseLineColor/TextInput.get_content("result")
	var cell : String = $BaseRow/BaseLineColor/TextInput2.get_content("cell1")
	var at : String = $BaseRow/BaseLineColor/TextInput3.get_content("0")

	return ["write " + r + " " + cell + " " + at]
