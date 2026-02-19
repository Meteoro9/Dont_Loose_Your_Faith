extends Area2D
class_name WinArea

@export var win_scene : PackedScene
#@export var loose_scene : PackedScene
@export var is_win : bool
@export var show_timer : CanvasLayer
@export var level_id : int

var timer : TimerRecord = null
var fire: FireBehaviour = null

func _ready() -> void:
	timer = show_timer.get_node("Label")
	fire = get_parent().get_node("Candle-Player/FireArea")

func _on_body_entered(body: Node2D) -> void:
	if body is CandlePlayer:
		# Detectamos su Animation player
		var anim_player = body.get_node_or_null("AnimationPlayer")
		timer.stop_timer()
		if is_win and not body.won:
			body.won = true
			if anim_player:
				anim_player.play("Goodbye_Darkness")
			
			GlobalMusicManager.current_state = GlobalMusicManager.Scene_State.WIN
			
			var scene = win_scene.instantiate()
			get_tree().root.add_child(scene)
			
			GameData.add_record(level_id, timer.current_time)
			
		elif not is_win: 
			if fire: fire.kill()
			GlobalMusicManager.current_state = GlobalMusicManager.Scene_State.LOOSE
