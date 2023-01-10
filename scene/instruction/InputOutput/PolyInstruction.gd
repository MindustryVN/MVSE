class_name PolyInstruction
extends Instruction

func abtr():
	color = Config.INSTRUCTION_COLOR["INPUT_OUTPUT"]
	add_output("output")
	add_input("input")
	


func get_content() -> Array:
	var x : String = $BaseRow/BaseLineColor/TextInput.get_content("0")
	var y : String = $BaseRow/BaseLineColor/TextInput2.get_content("0")
	var x2 : String = $BaseRow/BaseLineColor/TextInput3.get_content("0")
	var y2 : String = $BaseRow/BaseLineColor/TextInput4.get_content("0")

	return ["draw poly " \
	+ x + " " \
	+ y + " " \
	+ x2 + " " \
	+ y2 + " 0 0"]
