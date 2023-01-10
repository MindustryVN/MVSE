class_name JumpInstruction
extends Instruction

func abtr():
	color = Config.INSTRUCTION_COLOR["FLOW_CONTROL"]
	add_output("true")
	add_output("false")
	add_input("input")
	$BaseRow/BaseLineColor/SelectBox.add_options(Config.OPERATIONS)

func get_content() -> Array:
	var a : String = $BaseRow/BaseLineColor/TextInput.get_content("x")
	var b : String = $BaseRow/BaseLineColor/TextInput2.get_content("false")
	var op : String = $BaseRow/BaseLineColor/SelectBox. get_content("==")
	
	return ["jump " + str(output["true"].get_line()) + " " + op + " " + a + " " + b ]

func get_code() -> Array:
	var result : Array = []
	result.append_array(get_content())
	result.append_array(output["false"].get_code())
	result.append_array(output["true"].get_code())
	return result 
