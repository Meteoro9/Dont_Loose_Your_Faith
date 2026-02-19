extends Area2D
class_name FireBehaviour

const max_flame := 100.0
var current_flame := max_flame
var is_alive := true # Para evitar loopear método kill()
@export var bar : ProgressBar
@export var fire_animation : AnimatedSprite2D

@export var loose_menu : PackedScene

@onready var alive_audio = $FlameAlive
@onready var kill_audio = $FlameKill
@onready var candle = get_parent()

signal fire_killed

func take_damage(amount : float):
	if not candle.won:
		if current_flame - amount <= 0:
			kill()
		else:
			current_flame -= amount
		
		if current_flame < 0:
			current_flame = 0

func kill():
	if is_alive and not candle.won:
		current_flame -= 100 # Forzamos <= 0
		fire_animation.visible = false # "apagamos" el fuego animado
		alive_audio.stop() # Apagamos el sonido de fuego vivo
		kill_audio.play() # Reproducimos sonido de muerte
		is_alive = false
		
		fire_killed.emit()
		
		GlobalMusicManager.current_state = GlobalMusicManager.Scene_State.LOOSE
		var scene = loose_menu.instantiate()
		get_tree().root.add_child(scene)

func _process(_delta: float) -> void:
	if current_flame <= 0 and is_alive: # Si murió en este frame
		kill()
	elif current_flame < max_flame and is_alive: # para que no se recupere al morir
		current_flame += 0.5
	
	bar.value = current_flame

func _on_flame_alive_finished() -> void:
	alive_audio.play()
