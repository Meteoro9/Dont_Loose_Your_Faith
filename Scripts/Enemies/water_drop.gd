extends RigidBody2D
class_name WaterDrop

var damage := 100.0
var player_inside : CandlePlayer = null

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area is FireBehaviour:
		player_inside = area.get_parent()
		print("Le cayó agua al player")

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area == player_inside:
		player_inside = null
		print("El agua salió del player")

func _process(delta: float) -> void:
	if player_inside:
		var fire = player_inside.get_node("FireArea")
		if fire:
			fire.kill()

func _on_timer_timeout() -> void:
	queue_free()
