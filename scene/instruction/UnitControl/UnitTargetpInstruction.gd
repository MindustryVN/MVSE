class_name UnitTargetpInstruction
extends Instruction


func setup():
	color = Config.INSTRUCTION_COLOR["UNIT_CONTROL"]
	add_output("output")
	add_input("input")
	add_component("line2", "BaseLineColor", "row")
	add_component("text2", "CenterLabel", "line2").text = "unit"
	add_component("u", "TextBox", "line2")
	add_component("text3", "CenterLabel", "line2").text = "shoot"
	add_component("s", "TextBox", "line2")

func get_content() -> Array:
	var u : String = get_component_value("u", "0")
	var s : String = get_component_value("s", "0")

	return ["ucontrol targetp " + u + " " + s + " 0 0 0"]

