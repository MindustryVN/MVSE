class_name ShootInstruction
extends Instruction

func abtr():
	color = Config.INSTRUCTION_COLOR["BLOCK_CONTROL"]
	add_output("output")
	add_input("input")

func get_content() -> Array:
	var block : String = $BaseRow/BaseLineColor/TextInput.get_content("block1")
	var x : String = $BaseRow/BaseLineColor/TextInput2.get_content("0")
	var y : String = $BaseRow/BaseLineColor/TextInput3.get_content("0")
	var shoot : String = $BaseRow/BaseLineColor/TextInput4.get_content("0")

	return ["control shoot " + block + " " + x + " " + y + " " + shoot + " 0"]
