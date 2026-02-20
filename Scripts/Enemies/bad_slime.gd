extends CharacterBody2D
class_name BadSlime

enum State { ATTACKING, MOVING, FOLLOWING }

const SlimeEntity = preload("res://Scenes/Enemies/slime_trail.tscn")
const JUMP_VELOCITY = -400.0
var _current_state : State = State.MOVING
var damage := 4.0
var speed := 800.0
@export var trail_interval := 0.15 # Intervalo de depósito de moco
@export var end_position_right : float
var init_position_left : float
var yendo := true
var alive := true
var is_player_in_hitbox := false
var player : CandlePlayer
var _trail_timer := 0.0

#region COMPORTAMIENTOS
func _ready() -> void:
	init_position_left = global_position.x
	player = get_tree().get_first_node_in_group("player")
	$AnimatedSprite2D.frame_changed.connect(_on_attack_started)
	$HitBox.area_entered.connect(_kill_player)

func _process(delta: float) -> void:
	_trail_timer += delta
	if _trail_timer >= trail_interval:
		_trail_timer = 0.0
		_spawn_trail()
	
	if not is_on_floor(): velocity += get_gravity() * delta # Activamos gravedad
	
	_play_animation_and_motion(delta)
	move_and_slide()

func _spawn_trail():
	var trail = SlimeEntity.instantiate()
	get_parent().add_child(trail)
	trail.global_position = global_position + Vector2(0, 10)

func _play_animation_and_motion(_delta):
	await $AnimatedSprite2D.animation_finished
	if _current_state == State.MOVING or _current_state == State.FOLLOWING:
		_enemy_motion(_delta)
		$AnimatedSprite2D.play("idle")
	if _current_state == State.ATTACKING and alive:
		$AnimatedSprite2D.play("attack")

func _enemy_motion(_delta):
	if _current_state == State.MOVING:
		if yendo:
			if global_position.x <= end_position_right: 
				velocity.x = speed * _delta
			else: yendo = false
		else:
			if global_position.x >= init_position_left:
				velocity.x = -speed * _delta
			else: yendo = true
	if _current_state == State.FOLLOWING:
		var direction : float = sign(player.global_position.x - global_position.x)
		velocity.x = direction * speed * _delta

func _on_attack_started():
	if $AnimatedSprite2D.animation == "attack" and is_on_floor():
		velocity.y = JUMP_VELOCITY
#endregion

#region ÁREAS
# Área dañado
func _on_hurt_box_body_entered(body: Node2D) -> void:
	if body is CandlePlayer:
		alive = false
		await get_tree().create_timer(1.0).timeout
		queue_free()
	pass # Replace with function body.

func _kill_player(area: Area2D):
	if area is FireBehaviour: area.kill()

func _on_hurt_box_body_exited(body: Node2D) -> void:
	pass

# Área dañar
func _on_hit_box_body_entered(body: Node2D) -> void:
	if body is CandlePlayer: _current_state = State.ATTACKING



func _on_hit_box_body_exited(body: Node2D) -> void:
	if body is CandlePlayer: _current_state = State.FOLLOWING

# Área perseguir
func _on_area_follow_body_exited(body: Node2D) -> void:
	if body is CandlePlayer and _current_state == State.FOLLOWING:
		_current_state = State.MOVING # Para evitar comportamientos de seguimiento extraños
#endregion
