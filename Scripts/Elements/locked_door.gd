extends StaticBody2D
class_name LockedDoor

@export var texture_red : CompressedTexture2D
@export var texture_yellow : CompressedTexture2D
enum ButtonColor { YELLOW , RED }
@export var color_state : ButtonColor = ButtonColor.YELLOW
@export var button_to_unlock : ButtonBehaviour
var is_locking := true
#@export var key_to_unlock

func _ready() -> void:
	if color_state == ButtonColor.YELLOW: $Sprite2D.texture = texture_yellow
	elif color_state == ButtonColor.RED: $Sprite2D.texture = texture_red
	$AnimationPlayer.play("locked")

func _process(_delta: float) -> void:
	if button_to_unlock and is_locking:
		if button_to_unlock.is_active:
			is_locking = false
			$AnimationPlayer.play("unlock")
	#elif key_to_unlock:



func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "unlock":
		await $AnimationPlayer.animation_finished
		queue_free()
