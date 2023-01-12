class_name UnitBindInstruction
extends Instruction


func setup():
	color = Config.INSTRUCTION_COLOR["UNIT_CONTROL"]
	add_output("output")
	add_input("input")
	add_component("line2", "BaseLineColor", "row")
	add_component("text1", "CenterLabel", "line2").text = "type"
	add_component("block", "TextBox", "line2")

func get_content() -> Array:
	var unit : String = get_component_value("block","@flare")
	return ["ubind " + unit]
