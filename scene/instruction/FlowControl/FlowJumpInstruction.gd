class_name FlowJumpInstruction
extends Instruction

func setup():
	color = Config.INSTRUCTION_COLOR["FLOW_CONTROL"]
	add_output("true")
	add_output("false")
	add_input("input")
	add_component("line2", "BaseLineColor", "row")
	add_component("text1", "CenterLabel", "line2").text = "if"
	add_component("x", "TextBox", "line2")
	add_component("op", "SelectBox", "line2").add_options(Config.OPERATIONS)
	add_component("y", "TextBox", "line2")

func set_line() -> void:
	if line_set:
		return
		
	#Display line
	if component.has("line"):
		component["line"].text = str(Config.current_line)
	
	Config.current_line += 1
	line = Config.current_line
	line_set = true
	
	output["false"].set_line()
	if (output["false"].target == output["true"].target):
		return 
	output["true"].set_line()

func get_code() -> Array:
	var result : Array = []
	result.append_array(get_content())
	result.append_array(output["false"].get_code())
	if (output["false"].target == output["true"].target):
		return result
	result.append_array(output["true"].get_code())
	return result 

func get_content() -> Array:
	var op = get_component_value("op", "not")
	var eop = op
	match op:
		"==":
			eop = "equal"
		"===":
			eop = "strictEqual"
		"not":
			eop = "notEqual"
		">":
			eop = "greaterThan"
		">=":
			eop = "greaterThanEqual"
		"<":
			eop = "lessThan"
		"<=":
			eop = "lessThanEqual"
		
	return ["jump " + " " + str(output["true"].get_line()) + " " + eop + " " + get_component_value("x", "x") + " " + get_component_value("y", "false")]
