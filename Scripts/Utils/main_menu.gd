extends Control
class_name MainMenu

@onready var label_times_record = $LabelTimesRecord
@onready var label_day_record = $LabelDayRecord
@onready var label_hour_record = $LabelHourRecord
const LEVEL_ID := "level_sample"

var languages: Array[String] = ["en_US", "es_AR", "pt_BR", "zh_CN", "ja_JP", "ru_RU"]
var current_lang := "en_US"

var list_empty_string: Array[String] = ["(No records registered yet)", 
	"(Aún no se registró ningún tiempo)", "(Ainda não há tempos registrados)", 
	"（尚未记录任何时间）", "（まだ記録がありません）", "(Пока нет записанных результатов)"]

func _ready() -> void:
	update_text()
	# Actualizar la música al empezar
	GlobalMusicManager.current_state = GlobalMusicManager.Scene_State.MENU

func update_text():
	current_lang = TranslationServer.get_locale()
	var current_index = languages.find(current_lang)
	if current_index == -1:
		current_index = 0
	
	var records: Array[RecordData] = GameData.get_records(LEVEL_ID)
	
	if records.is_empty():
		label_times_record.text = list_empty_string[current_index]
		label_day_record.text = ""
		label_hour_record.text = ""
		return
	
	var ordered_records := records.duplicate()
	ordered_records.reverse()
	
	var times_text := ""
	var days_text := ""
	var hours_text := ""
	
	for record in ordered_records:
		times_text += "* %.2f\n" % record.time
		days_text += record.day + "\n"
		hours_text += record.hour + "\n"
	
	label_times_record.text = times_text
	label_day_record.text = days_text
	label_hour_record.text = hours_text


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
