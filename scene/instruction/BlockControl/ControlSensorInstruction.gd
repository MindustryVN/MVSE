class_name ControlSensorInstruction
extends Instruction


func setup():
	color = Config.INSTRUCTION_COLOR["BLOCK_CONTROL"]
	add_output("output")
	add_input("input")
	add_component("line2", "BaseLineColor", "row")
	add_component("result", "TextBox", "line2")
	add_component("text1", "CenterLabel", "line2").text = "="
	add_component("type", "TextBox", "line2")
	add_component("text2", "CenterLabel", "line2").text = "in"
	add_component("source", "TextBox", "line2")

func get_content() -> Array:
	var result : String = get_component_value("result","result")
	var type : String = get_component_value("type","@copper")
	var source : String = get_component_value("source","block1")
	

	return ["sensor " + result + " " + source + " " + type]

