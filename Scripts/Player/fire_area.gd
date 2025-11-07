extends Area2D
class_name FireBehaviour

const max_flame := 100.0
var current_flame := max_flame
@export var bar : ProgressBar
@export var fire_animation : AnimatedSprite2D

func take_damage(amount : float):
	current_flame -= amount
	
	if current_flame < 0:
		current_flame = 0

func kill():
	current_flame -= 100
	fire_animation.visible = false

func _process(_delta: float) -> void:
	if current_flame <= 0:
		kill()
	elif current_flame < max_flame: # para que no se recupere al morir
		current_flame += 0.5
	
	bar.value = current_flame
