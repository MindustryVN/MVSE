class_name SensorInstruction
extends Instruction

func abtr():
	color = Config.INSTRUCTION_COLOR["BLOCK_CONTROL"]
	add_input("input")
	add_output("output")
	$BaseRow/BaseLineColor/SelectBox.add_option_icons(Config.ITEMS).add_option_icons(Config.LIQUIDS)

func get_content() -> Array:
	var variable = $BaseRow/BaseLineColor/TextInput.get_content("result")
	var value = $BaseRow/BaseLineColor/SelectBox.get_content("block1")
	var value2 = $BaseRow/BaseLineColor/TextInput3.get_content("@copper")
	
	return ["sensor " + variable + " " + value + " " + value2 ]

