class_name UnitLocateBuildingInstruction
extends Instruction


func setup():
	color = Config.INSTRUCTION_COLOR["UNIT_CONTROL"]
	add_output("output")
	add_input("input")
	add_component("line7", "BaseLineColor", "row")
	add_component("row2", "BaseRow", "line7")
	add_component("line2", "BaseLineColor", "row2")
	add_component("line3", "BaseLineColor", "row2")
	add_component("line4", "BaseLineColor", "row2")


	add_component("text2", "CenterLabel", "line2").text = "group"
	add_component("group", "SelectBox", "line2").add_options(Config.LOCATE_GROUP)
	add_component("text3", "CenterLabel", "line2").text = "enemy"
	add_component("enemy", "TextBox", "line2")
	add_component("text4", "CenterLabel", "line3").text = "outx"
	add_component("outx", "TextBox", "line3")
	add_component("text5", "CenterLabel", "line3").text = "outy"
	add_component("outy", "TextBox", "line3")
	add_component("text6", "CenterLabel", "line4").text = "found"
	add_component("found", "TextBox", "line4")
	add_component("text7", "CenterLabel", "line4").text = "building"
	add_component("building", "TextBox", "line4")



func get_content() -> Array:
	var group : String = get_component_value("group","core")
	var enemy : String = get_component_value("enemy","true")
	var outx : String = get_component_value("outx","outy")
	var outy : String = get_component_value("outy","outx")
	var found : String = get_component_value("found","found")
	var building : String = get_component_value("building","building")
	
	return ["ulocate building " + group + " " + enemy + " nah " + outx + " " + outy + " " + found + " " + building]
	
