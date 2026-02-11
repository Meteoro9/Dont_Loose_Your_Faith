extends Area2D
class_name KeyCollectable

@export var texture_red : CompressedTexture2D
@export var texture_yellow : CompressedTexture2D
enum ButtonColor { YELLOW , RED }
@export var color_state : ButtonColor = ButtonColor.YELLOW
var is_picked := false

func _ready() -> void:
	if color_state == ButtonColor.YELLOW: $Sprite2D.texture = texture_yellow
	elif color_state == ButtonColor.RED: $Sprite2D.texture = texture_red


func _on_body_entered(body: Node2D) -> void:
	if body is CandlePlayer and not is_picked:
		is_picked = true
		print("El jugador agarró la llave")
		
		$Sprite2D.modulate = Color(1, 1, 1, 0)
