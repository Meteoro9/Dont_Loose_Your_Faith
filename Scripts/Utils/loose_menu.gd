extends CanvasLayer

func on_retry_pressed():
	LoadBar.fade_to_scene(GameManager.level_paths[GameManager.current_level_index])
	queue_free()

func on_go_menu_pressed():
	LoadBar.fade_to_scene("res://Scenes/Levels/main_menu.tscn")
	queue_free()
