class_name ImageInstruction
extends Instruction

func abtr():
	color = Config.INSTRUCTION_COLOR["INPUT_OUTPUT"]
	add_output("output")
	add_input("input")
	


func get_content() -> Array:
	var x : String = $BaseRow/BaseLineColor/TextInput.get_content("0")
	var y : String = $BaseRow/BaseLineColor/TextInput2.get_content("0")
	var image : String = $BaseRow/BaseLineColor/TextInput3.get_content("@ohno")
	var image_size : String = $BaseRow/BaseLineColor/TextInput4.get_content("32")
	var image_rotation : String = $BaseRow/BaseLineColor/TextInput4.get_content("0")
	
	return ["draw image " + x + " " + y + " " + image + " " + image_size + " " + image_rotation + " 0"]
