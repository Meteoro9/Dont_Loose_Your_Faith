extends CharacterBody2D
class_name CandleController

var speed := 30
var gravity := 800.0
var direction := Vector2.ZERO

func CheckInputs():
	if Input.is_action_just_pressed("arriba"):
		direction += Vector2(0, -10)
	if Input.is_action_pressed("derecha"):
		direction += Vector2(1, 0)
	if Input.is_action_pressed("izquierda"):
		direction += Vector2(-1, 0)

func AplyInputs():
	direction = direction.normalized()
	velocity = direction * speed
	move_and_slide()

func _process(_delta: float) -> void:
	direction = Vector2.ZERO
	CheckInputs()
	AplyInputs()

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()
