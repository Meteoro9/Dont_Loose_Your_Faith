extends Area2D
class_name WoodBehaviour

var player_inside : CandlePlayer = null

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area is FireBehaviour:
		player_inside = area.get_parent()
		print("El player quemó la madera")

func _process(_delta: float) -> void:
	if player_inside:
		var fire = player_inside.get_node("FireArea")
		player_inside = null
		if fire and $AnimationPlayer.is_playing():
			$AnimationPlayer.play("fire")

func _on_timer_timeout() -> void:
	queue_free()

func kill():
	$Timer.start()
	print("Comenzó el timer")
