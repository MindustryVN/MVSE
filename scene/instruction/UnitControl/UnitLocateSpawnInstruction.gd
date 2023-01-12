class_name UnitLocateSpawnInstruction
extends Instruction


func setup():
	color = Config.INSTRUCTION_COLOR["UNIT_CONTROL"]
	add_output("output")
	add_input("input")
	add_component("line7", "BaseLineColor", "row")
	add_component("row2", "BaseRow", "line7")
	add_component("line3", "BaseLineColor", "row2")
	add_component("line4", "BaseLineColor", "row2")
	

	add_component("text4", "CenterLabel", "line3").text = "outx"
	add_component("outx", "TextBox", "line3")
	add_component("text5", "CenterLabel", "line3").text = "outy"
	add_component("outy", "TextBox", "line3")
	add_component("text6", "CenterLabel", "line4").text = "found"
	add_component("found", "TextBox", "line4")
	add_component("text2", "CenterLabel", "line4").text = "building"
	add_component("building", "TextBox", "line4")



func get_content() -> Array:
	var building : String = get_component_value("building","building")
	var outx : String = get_component_value("outx","outy")
	var outy : String = get_component_value("outy","outx")
	var found : String = get_component_value("found","found")

	
	return ["ulocate spawn core true @copper " + outx + " " + outy + " " + found + " " + building]
