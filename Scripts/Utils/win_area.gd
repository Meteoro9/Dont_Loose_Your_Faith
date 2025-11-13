extends Area2D
class_name WinArea

@export var win_scene : PackedScene
@export var show_timer : CanvasLayer
var timer : TimerRecord = null

func _ready() -> void:
	timer = show_timer.get_node("Label")

func _on_body_entered(body: Node2D) -> void:
	if body is CandlePlayer:
		var scene = win_scene.instantiate()
		get_tree().root.add_child(scene)
		
		timer.stop_timer()
		
		GameData.add_time(timer.current_time)
