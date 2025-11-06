extends AnimationPlayer
class_name CandleAnimations

@export var animated_sprite : AnimatedSprite2D
@export var candle : CharacterBody2D
@export var fire : Area2D


func _ready() -> void:
	play("Fire")
	animated_sprite.play("Fire")

func _process(_delta: float) -> void:
	if fire.current_flame <= 0:
		if current_animation != "kill" and current_animation != "stay_killed":
				play("kill")
		else:
			await animation_finished
			play("stay_killed")
