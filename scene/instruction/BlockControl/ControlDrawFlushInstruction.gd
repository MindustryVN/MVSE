class_name ControlDrawFlushInstruction
extends Instruction


func setup():
	color = Config.INSTRUCTION_COLOR["BLOCK_CONTROL"]
	add_output("output")
	add_input("input")
	add_component("line2", "BaseLineColor", "row")
	add_component("text1", "CenterLabel", "line2").text = "to"
	add_component("display", "TextBox", "line2")

func get_content() -> Array:
	var display : String = get_component_value("display","display1")

	return ["drawflush " + display]

