class_name StartException
extends LogicException

var current : int = 0

func check() -> void:
	var s : int = get_tree().get_nodes_in_group("Start").size()
	if s != 1:
		print_error("There must be 1 start instruction in your logic, found " + str(s))
	else:
		delete_log()

func execute() -> void:
	var nodes : Array = get_tree().get_nodes_in_group("Start")
	if nodes.size() == 0:
		return
	var tween = get_tree().create_tween()
	current %= nodes.size()
	tween.tween_property(Config.current_camera,"global_position", nodes[current].global_position + nodes[current].get_size()/2, 0.3).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	current += 1
