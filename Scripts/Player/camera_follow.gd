extends Camera2D
class_name CameraFollow

@export var player : Node2D
var follow_speed := 6.0

func _ready() -> void:
	global_position = player.global_position

func _process(delta: float) -> void:
	var target := player.global_position.y
	# Interpolación suave de la cámara
	global_position.y = lerp(global_position.y, target, follow_speed * delta)
