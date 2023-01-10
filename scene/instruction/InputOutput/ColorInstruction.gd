class_name ColorInstruction
extends Instruction

func abtr():
	color = Config.INSTRUCTION_COLOR["INPUT_OUTPUT"]
	add_output("output")
	add_input("input")


func get_content() -> Array:
	var r : String = $BaseRow/BaseLineColor/TextInput.get_content("0")
	var g : String = $BaseRow/BaseLineColor/TextInput2.get_content("0")
	var b : String = $BaseRow/BaseLineColor/TextInput3.get_content("0")
	var a : String = $BaseRow/BaseLineColor/TextInput4.get_content("0")

	return ["draw color " + r + " " + g + " " + b + " " + a + " 0 0"]

