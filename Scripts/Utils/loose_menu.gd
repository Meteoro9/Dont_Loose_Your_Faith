extends CanvasLayer

func on_retry_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/sample_level.tscn")
	queue_free()

func on_go_menu_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/main_menu.tscn")
	queue_free()
