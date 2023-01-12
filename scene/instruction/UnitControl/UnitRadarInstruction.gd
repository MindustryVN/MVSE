class_name UnitRadarInstruction
extends Instruction


func setup():
	color = Config.INSTRUCTION_COLOR["UNIT_CONTROL"]
	add_output("output")
	add_input("input")
	add_component("line4", "BaseLineColor", "row")
	add_component("row2", "BaseRow", "line4")
	add_component("line2", "BaseLineColor", "row2")
	add_component("line3", "BaseLineColor", "row2")
	add_component("line4", "BaseLineColor", "row2")
	add_component("text2", "CenterLabel", "line2").text = "target"
	add_component("target", "SelectBox", "line2").add_options(Config.TARGET_TYPES)
	add_component("text3", "CenterLabel", "line2").text = "and"
	add_component("and1", "SelectBox", "line2").add_options(Config.TARGET_TYPES)
	add_component("text4", "CenterLabel", "line3").text = "and"
	add_component("and2", "SelectBox", "line3").add_options(Config.TARGET_TYPES)
	add_component("text5", "CenterLabel", "line3").text = "order"
	add_component("order", "TextBox", "line3")
	add_component("text6", "CenterLabel", "line4").text = "sort"
	add_component("sort", "SelectBox", "line4").add_options(Config.SORT_TYPES)
	add_component("text7", "CenterLabel", "line4").text = "output"
	add_component("output", "TextBox", "line4")



func get_content() -> Array:
	var target : String = get_component_value("target","enemy")
	var and1 : String = get_component_value("and1","any")
	var and2 : String = get_component_value("and2","any")
	var order : String = get_component_value("order","1")
	var sort : String = get_component_value("sort","distance")
	var outputt : String = get_component_value("output","result")
	
	return ["uradar " + target + " " + and1 + " " + and2 + " " + sort + " 0 " + order + " " + outputt]
	


	

