extends Node2D
class_name MusicManager

@onready var music_player = $"Music-Player"
var track_list = { 
	"Menu": preload("res://Audio/Music/poopie pack/town.ogg"),
	"Level1": preload("res://Audio/Music/poopie pack/boss battle.ogg"),
	"Pause": preload("res://Audio/Music/poopie pack/shop.ogg"),
	"Win": preload("res://Audio/Music/poopie pack/blossom.ogg"),
	"Loose": preload("res://Audio/Music/poopie pack/journey.ogg")
}

func _ready() -> void:
	get_tree().node_added.connect(on_node_added)

func on_node_added(node : Node):
	await get_tree().process_frame # Esperamos el primer frame
	
	var current_scene = get_tree().current_scene
	print(current_scene)
	
	if current_scene:
		#play_music_for_scene(current_scene.name)
		pass



func fade_transition_music(scene_name: String):
	# Crear sistema de comparación
	var new_song = track_list["Menu"]
	
	var tween = create_tween()
	tween.tween_property(music_player, "volume_db",
		 -80.0, 1.0).set_trans(Tween.TRANS_SINE)
	
	tween.tween_callback(func():
		music_player.stream = new_song
		music_player.play()
	)
	
	tween.tween_property(music_player, "volume_db", 
		0.0, 1.0).set_trans(Tween.TRANS_SINE)
	pass
