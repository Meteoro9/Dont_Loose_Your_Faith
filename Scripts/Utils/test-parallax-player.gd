extends Sprite2D

func _process(delta: float) -> void:
	global_position.y -= 50 * delta
