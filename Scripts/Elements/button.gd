extends Area2D
class_name ButtonBehaviour

enum ButtonColor { YELLOW , RED }
@export var color_state : ButtonColor = ButtonColor.YELLOW
# Declarar variable exportada Puerta, o al revés en la puerta
var is_active := false

func _ready() -> void:
	if color_state == ButtonColor.YELLOW: $Animation.play("default_yellow")
	elif color_state == ButtonColor.RED: $Animation.play("default_red")

func _on_body_entered(body: Node2D) -> void:
	if body is CandlePlayer and not is_active:
		is_active = true
		print("El jugador presionó el botón")
		if color_state == ButtonColor.YELLOW: $Animation.play("pressed_yellow")
		elif color_state == ButtonColor.RED: $Animation.play("pressed_red")
