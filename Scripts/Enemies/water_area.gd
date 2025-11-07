extends Area2D
class_name WaterArea

var damage := 50.0
var player_inside : CandlePlayer = null

func _on_body_entered(body: Node2D) -> void:
	if body is CandlePlayer:
		player_inside = body
		print("Entro el jugador al agua")

func _on_body_exited(body: Node2D) -> void:
	if body == player_inside:
		player_inside = null
		print("El jugador salió del agua")

func _process(delta: float) -> void:
	if player_inside:
		var fire = player_inside.get_node("FireArea")
		if fire:
			fire.take_damage(damage * delta)
