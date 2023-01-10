class_name RadarInstruction
extends Instruction

func abtr():
	color = Config.INSTRUCTION_COLOR["BLOCK_CONTROL"]
	add_output("output")
	add_input("input")
	$BaseLineColor/BaseRow/BaseLineColor/SelectBox.add_options(Config.TARGET_TYPES)
	$BaseLineColor/BaseRow/BaseLineColor/SelectBox2.add_options(Config.TARGET_TYPES)
	$BaseLineColor/BaseRow/BaseLineColor/SelectBox3.add_options(Config.TARGET_TYPES)
	$BaseLineColor/BaseRow/BaseLineColor2/SelectBox.add_options(Config.SORT_TYPES)


func get_content() -> Array:
	var from : String = $BaseLineColor/BaseRow/BaseLineColor/TextInput.get_content("turret1")
	var target : String = $BaseLineColor/BaseRow/BaseLineColor/SelectBox.get_content("enemy")
	var any1 : String  = $BaseLineColor/BaseRow/BaseLineColor/SelectBox2.get_content("any")
	var any2 : String = $BaseLineColor/BaseRow/BaseLineColor/SelectBox3.get_content("any")
	var order : String = $BaseLineColor/BaseRow/BaseLineColor2/TextInput.get_content("1")
	var sort : String = $BaseLineColor/BaseRow/BaseLineColor2/SelectBox.get_content("distance")
	var ouput : String = $BaseLineColor/BaseRow/BaseLineColor2/TextInput3.get_content("output")

	return ["radar " + target + " " + any1 + " " + any2 + " " + sort + " " + from + " " + order + " " + ouput]

