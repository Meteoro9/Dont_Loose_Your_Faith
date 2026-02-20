extends Node
class_name LevelManager

@export var level_id: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalMusicManager.current_state = GlobalMusicManager.Scene_State.LEVEL1
	GameManager.current_level_index = level_id
