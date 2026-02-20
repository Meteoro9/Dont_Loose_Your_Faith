extends CharacterBody2D
class_name CandlePlayer

const SPEED = 300.0
const JUMP_VELOCITY = -530.0

@export var fire_behaviour : FireBehaviour
var won := false

#region Movement
# Script de plantilla integrada en el motor, muy leves modificaciones
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if not won:
		# Handle jump.
		if Input.is_action_pressed("arriba") and is_on_floor() and not _in_slime:
			velocity.y = JUMP_VELOCITY
		
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction := Input.get_axis("izquierda", "derecha")
		if direction:
			var target_x = direction * SPEED
			
			# Ejecutamos mecánica principal
			fire_behaviour.take_damage(1.5)
			if fire_behaviour.current_flame <= 0.0:
				fire_behaviour.kill()
			#endregion
			#region Aply States
			# Esta sentencia es una locura!!!
			var friction = _slime_friction if _in_slime else _normal_friction
			# Aplicamos fricción a la velocidad
			velocity.x = lerp(velocity.x, target_x, friction)
		else:
			var stop_friction = _slime_friction if _in_slime else 1.0
			velocity.x = lerp(velocity.x, 0.0, stop_friction)
			#velocity.x = move_toward(velocity.x, 0, SPEED) # Código original
			#endregion
	
	move_and_slide()

#region States
var _active_slime_trails : Array[SlimeTrail] = []
var _normal_friction := 0.85

var _in_slime: bool:
	get: return not _active_slime_trails.is_empty()

var _slime_friction: float:
	get:
		if _active_slime_trails.is_empty(): return _normal_friction
		return _active_slime_trails.map(func(t): return t.friction_override).min()

func aply_slime_effect(trail: SlimeTrail) -> void:
	if trail not in _active_slime_trails: _active_slime_trails.append(trail)

func remove_slime_effect(trail: SlimeTrail) -> void:
	_active_slime_trails.erase(trail)
#endregion
