class_name UnitStopInstruction
extends Instruction


func setup():
	color = Config.INSTRUCTION_COLOR["UNIT_CONTROL"]
	add_output("output")
	add_input("input")
	add_component("line2", "BaseLineColor", "row")

func get_content() -> Array:
	return ["ucontrol stop 0 0 0 0 0"]

