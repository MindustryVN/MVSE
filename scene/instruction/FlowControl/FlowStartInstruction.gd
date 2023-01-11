class_name FlowStartInstruction
extends Instruction


func setup():
	color = Config.INSTRUCTION_COLOR["FLOW_CONTROL"]
	add_output("output")
	add_to_group("Start")
	add_component("line2", "BaseLineColor", "row")

func get_content() -> Array:
	return []
