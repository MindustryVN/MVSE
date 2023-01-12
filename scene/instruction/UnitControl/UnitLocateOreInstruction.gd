class_name UnitLocateOreInstruction
extends Instruction


func setup():
	color = Config.INSTRUCTION_COLOR["UNIT_CONTROL"]
	add_output("output")
	add_input("input")
	add_component("line7", "BaseLineColor", "row")
	add_component("row2", "BaseRow", "line7")
	add_component("line2", "BaseLineColor", "row2")
	add_component("line3", "BaseLineColor", "row2")
	

	add_component("text2", "CenterLabel", "line2").text = "ore"
	add_component("ore", "TextBox", "line2")
	add_component("text4", "CenterLabel", "line3").text = "outx"
	add_component("outx", "TextBox", "line3")
	add_component("text5", "CenterLabel", "line3").text = "outy"
	add_component("outy", "TextBox", "line3")
	add_component("text6", "CenterLabel", "line2").text = "found"
	add_component("found", "TextBox", "line2")



func get_content() -> Array:
	var ore : String = get_component_value("ore","@copper")
	var outx : String = get_component_value("outx","outy")
	var outy : String = get_component_value("outy","outx")
	var found : String = get_component_value("found","found")

	
	return ["ulocate ore core true " + ore + " " + outx + " " + outy + " " + found + " building"]
