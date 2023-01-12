class_name OperationSetInstruction
extends Instruction


func setup():
	color = Config.INSTRUCTION_COLOR["OPERATIONS"]
	add_output("output")
	add_input("input")

	add_component("line2", "BaseLineColor", "row")
	add_component("result", "TextBox", "line2")
	add_component("text2", "CenterLabel", "line2").text = "="
	add_component("value", "TextBox", "line2")


func get_content() -> Array:
	var result : String = get_component_value("result", "result")
	var value : String = get_component_value("value", "0")
	return ["set " + result + " " + value]
