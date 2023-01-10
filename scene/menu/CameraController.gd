extends Camera2D

func update():
	global_position = global_position.clamp(Vector2(-Config.MAX_WORLD_SIZE,-Config.MAX_WORLD_SIZE),Vector2(Config.MAX_WORLD_SIZE,Config.MAX_WORLD_SIZE))
