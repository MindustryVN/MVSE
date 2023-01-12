class_name OperationAbsInstruction
extends Instruction


func setup():
	color = Config.INSTRUCTION_COLOR["OPERATIONS"]
	add_output("output")
	add_input("input")

	add_component("line2", "BaseLineColor", "row")
	add_component("result", "TextBox", "line2")
	add_component("text2", "CenterLabel", "line2").text = "="
	add_component("text3", "CenterLabel", "line2").text = "abs"
	add_component("a", "TextBox", "line2")


func get_content() -> Array:
	var result : String = get_component_value("result", "result")
	var a : String = get_component_value("a", "a")
	return ["op abs " + result + " " + a + " 0"]

