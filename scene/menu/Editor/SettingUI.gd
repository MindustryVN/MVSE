extends VFlowContainer

var is_showing : bool = false

func _ready():
	$Button.button_down.connect(on_press.bind())
	
func on_press():
	is_showing = not is_showing
	$VBoxContainer.visible = is_showing

	
