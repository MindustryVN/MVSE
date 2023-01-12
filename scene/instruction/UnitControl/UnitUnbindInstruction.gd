class_name UnitUnbindInstruction
extends Instruction


func setup():
	color = Config.INSTRUCTION_COLOR["UNIT_CONTROL"]
	add_output("output")
	add_input("input")
	add_component("line2", "BaseLineColor", "row")

func get_content() -> Array:
	return ["ucontrol unbind 0 0 0 0 0"]


