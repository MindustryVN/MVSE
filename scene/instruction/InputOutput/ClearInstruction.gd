class_name ClearInstruction
extends Instruction

func abtr():
	color = Config.INSTRUCTION_COLOR["INPUT_OUTPUT"]
	add_output("output")
	add_input("input")

func get_content() -> Array:
	var r : String = $BaseRow/BaseLineColor/TextInput.get_content("0")
	var g : String = $BaseRow/BaseLineColor/TextInput2.get_content("0")
	var b : String = $BaseRow/BaseLineColor/TextInput3.get_content("0")

	return ["draw clear " + r + " " + g + " " + b + " 0 0 0"]

