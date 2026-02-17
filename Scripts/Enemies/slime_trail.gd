extends Area2D
class_name SlimeTrail

@export var lifetime := 8.0
@export var friction_override := 0.02 # muy poca fricción
var _timer := 0.0

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _process(delta: float) -> void:
	_timer += delta
	if _timer >= lifetime: 
		for body in get_overlapping_bodies():
			if body is CandlePlayer: body.remove_slime_effect(self)
		queue_free()

func _on_body_entered(body: Node2D):
	if body is CandlePlayer: body.aply_slime_effect(self)

func _on_body_exited(body: Node2D):
	if body is CandlePlayer: body.remove_slime_effect(self)
