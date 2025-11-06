extends RigidBody2D
class_name WaterDrop

var damage := 100.0
var player_inside : CandlePlayer = null

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CandlePlayer:
		player_inside = body
		print("Le cayó agua al player")

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == player_inside:
		player_inside = null
		print("El agua salió del player")

func _process(delta: float) -> void:
	if player_inside:
		var fire = player_inside.get_node("FireArea")
		if fire:
			fire.kill()

func _on_timer_timeout() -> void:
	queue_free()
