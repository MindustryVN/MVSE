class_name UnitBuildInstruction
extends Instruction


func setup():
	color = Config.INSTRUCTION_COLOR["UNIT_CONTROL"]
	add_output("output")
	add_input("input")


	add_component("line2", "BaseLineColor", "row")
	add_component("line3", "BaseLineColor", "row")
	add_component("line5", "BaseLineColor", "row")
	add_component("text1", "CenterLabel", "line2").text = "x"
	add_component("x", "TextBox", "line2")
	add_component("text2", "CenterLabel", "line2").text = "y"
	add_component("y", "TextBox", "line2")
	add_component("text3", "CenterLabel", "line3").text = "block"
	add_component("block", "TextBox", "line3")
	add_component("text5", "CenterLabel", "line3").text = "rotation"
	add_component("rot", "TextBox", "line3")
	add_component("text4", "CenterLabel", "line5").text = "config"
	add_component("config", "TextBox", "line5")

func get_content() -> Array:
	var x : String = get_component_value("x", "0")
	var y : String = get_component_value("y", "0")
	var block : String = get_component_value("block", "0")
	var config : String = get_component_value("config", "0")
	var rot : String = get_component_value("rot", "0")
	return ["ucontrol build " + x + " " + y + " " + block + " " + rot + " " + config]
