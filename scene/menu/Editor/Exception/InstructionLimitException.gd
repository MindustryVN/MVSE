class_name InstructionLimitException
extends LogicException

var current : int = 0

func check() -> void:
	if is_inside_tree():
		var s : int = get_tree().get_nodes_in_group("Instruction").size()
		if s > 1000:
			print_error("The number of instruction reached the limit 1000, found " + str(s))
		else:
			delete_log()

func execute():
	pass
