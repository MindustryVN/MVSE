class_name UnitWithinInstruction
extends Instruction


func setup():
	color = Config.INSTRUCTION_COLOR["UNIT_CONTROL"]
	add_output("output")
	add_input("input")

	add_component("line2", "BaseLineColor", "row")
	add_component("line3", "BaseLineColor", "row")
	add_component("text1", "CenterLabel", "line2").text = "x"
	add_component("x", "TextBox", "line2")
	add_component("text2", "CenterLabel", "line2").text = "y"
	add_component("y", "TextBox", "line2")
	add_component("text3", "CenterLabel", "line3").text = "radius"
	add_component("radius", "TextBox", "line3")
	add_component("text5", "CenterLabel", "line3").text = "result"
	add_component("result", "TextBox", "line3")


func get_content() -> Array:
	var x : String = get_component_value("x", "0")
	var y : String = get_component_value("y", "0")
	var radius : String = get_component_value("radius", "0")
	var result : String = get_component_value("result", "0")

	return ["ucontrol getBlock " + x + " " + y + " " + radius + " " + result + " 0"]
