extends Control
class_name MainMenu

@onready var level_info = $"Level Show Info"
@onready var animation = $AnimationPlayer

var languages: Array[String] = ["en_US", "es_AR", "pt_BR", "zh_CN", "ja_JP", "ru_RU"]
var current_lang := "en_US"

func _ready() -> void:
	level_info.visible = false
	# Cambiar estado de la música:
	await get_tree().process_frame # Esperamos el primer frame
	GlobalMusicManager.current_state = GlobalMusicManager.Scene_State.MENU

func _on_button_pressed() -> void:
	level_info.visible = true
	level_info.show_level_info()
	animation.play("hide_menu")

func on_language_pressed():
	# Buscamos el índice actual
	current_lang = TranslationServer.get_locale()
	var current_index = languages.find(current_lang)
	# Preseteamos un default en caso de error
	if current_index == -1: current_index = 0
	# Cambiamos al siguiente en la lista
	var next_index = (current_index + 1) % languages.size()
	change_language(languages[next_index])
	level_info.show_info(level_info.level_info_array_ordered[level_info.current_level_index])


func change_language(lang: String) -> void:
	TranslationServer.set_locale(lang)
