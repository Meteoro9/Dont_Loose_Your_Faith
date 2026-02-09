extends Control
class_name MainMenu

@onready var label_times_record = $LabelTimesRecord
@onready var label_day_record = $LabelDayRecord
@onready var label_hour_record = $LabelHourRecord
var languages: Array[String] = ["en_US", "es_AR", "pt_BR", "zh_CN", "ja_JP", "ru_RU"]
var current_lang := "en_US"

var list_empty_string: Array[String] = ["(No records registered yet)", 
	"(Aún no se registró ningún tiempo)", "(Ainda não há tempos registrados)", 
	"（尚未记录任何时间）", "（まだ記録がありません）", "(Пока нет записанных результатов)"]

func _ready() -> void:
	update_text()

func update_text():
	current_lang = TranslationServer.get_locale()
	var current_index = languages.find(current_lang)
	if current_index == -1: current_index = 0
	var final_text : String
	var record_list = GameData.records
	
	if record_list.is_empty():
		final_text = list_empty_string[current_index]
	else:
		# Duplicamos el array y lo reordenamos al revés, el último queda arriba
		var splash_record_list = record_list.duplicate()
		splash_record_list.reverse()
		for record in splash_record_list:
			# Creamos un string formateado
			var time_formatted = "%.2f" % record
			# Lo añadimos a el string final
			final_text += "* " + time_formatted + "\n"
	
	# Actualizamos label
	label_times_record.text = final_text
	
	# Cambiar estado de la música:
	await get_tree().process_frame # Esperamos el primer frame
	GlobalMusicManager.current_state = GlobalMusicManager.Scene_State.MENU

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/sample_level.tscn")

func on_language_pressed():
	# Buscamos el índice actual
	current_lang = TranslationServer.get_locale()
	var current_index = languages.find(current_lang)
	# Preseteamos un default en caso de error
	if current_index == -1: current_index = 0
	# Cambiamos al siguiente en la lista
	var next_index = (current_index + 1) % languages.size()
	change_language(languages[next_index])
	
	update_text()

func change_language(lang: String) -> void:
	TranslationServer.set_locale(lang)
