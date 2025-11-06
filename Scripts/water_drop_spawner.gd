extends Node2D
class_name WaterDropSpawner

@export var waterdrop : PackedScene

func _on_timer_timeout() -> void:
	var new_waterdrop = waterdrop.instantiate()
	add_child(new_waterdrop)
