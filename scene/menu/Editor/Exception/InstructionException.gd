class_name InstructionException
extends LogicException

var current : int = 0

func check() -> void:
	if is_inside_tree():
		var s : int = get_tree().get_nodes_in_group("Instruction").size()
		if s < 1:
			print_warning("There must be at least 1 instruction in your logic, found " + str(s))
		else:
			delete_log()

func execute():
	pass
