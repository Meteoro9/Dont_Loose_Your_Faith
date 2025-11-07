extends CharacterBody2D
class_name CandlePlayer

const SPEED = 300.0
const JUMP_VELOCITY = -550.0

@export var fire_animation : Area2D

# Script de plantilla integrada en el motor, muy leves modificaciones
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("arriba") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("izquierda", "derecha")
	if direction:
		velocity.x = direction * SPEED
		
		# Ejecutamos mecánica principal
		fire_animation.take_damage(1.5)
		if fire_animation.current_flame <= 0:
			fire_animation.kill()
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
