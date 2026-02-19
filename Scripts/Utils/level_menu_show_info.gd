extends Control
class_name LevelShowInfo

@export var times_record_label : Label
@export var day_record_label : Label
@export var hour_record_label : Label
@export var stars_record_label : Label

@export var level_info_array_ordered : Array[LevelSummaryMenu]
var _current_index := 0
@export var h_box_container : HBoxContainer
@export var animation : AnimationPlayer

var languages: Array[String] = ["en_US", "es_AR", "pt_BR", "zh_CN", "ja_JP", "ru_RU"]
var current_lang := "en_US"
var list_empty_string: Array[String] = ["(No records registered yet)", 
	"(Aún no se registró ningún tiempo)", "(Ainda não há tempos registrados)", 
	"（尚未记录任何时间）", "（まだ記録がありません）", "(Пока нет записанных результатов)"]


func _ready() -> void:
	animation.play("init")
	await get_tree().create_timer(1.0).timeout
	_show_info(level_info_array_ordered[0])
	h_box_container.alignment = BoxContainer.ALIGNMENT_CENTER
	h_box_container.global_position.y = h_box_container.global_position.y -20

func _show_info(summary: LevelSummaryMenu) -> void:
	current_lang = TranslationServer.get_locale()
	var current_lang_index = languages.find(current_lang)
	if current_lang_index == -1: current_lang_index = 0
	
	var times_text := ""
	var day_text := ""
	var hour_text := ""
	var stars_text := ""
	
	if summary.processed_records.is_empty():
		times_text = list_empty_string[current_lang_index]
	else:
		for entry in summary.processed_records:
			times_text += "*" + entry["time"] + "\n"
			day_text += entry["date"] + "\n"
			hour_text += entry["hour"] + "\n"
			stars_text += "★".repeat(entry["stars"]) + "☆".repeat(5 - entry["stars"]) + "\n"
		
	times_record_label.text = times_text
	day_record_label.text = day_text
	hour_record_label.text = hour_text
	stars_record_label.text = stars_text

func show_level_info():
	animation.play("appear")
	await animation.animation_finished
	animation.play("default")

func hide_level_info():
	animation.play("desappear")
	await animation.animation_finished
	visible = false
	var animation_menu = get_parent().get_node("AnimationPlayer")
	animation_menu.play("show_menu")

""" Antigua implementación del lenguaje en menú
	current_lang = TranslationServer.get_locale()
	var current_index = languages.find(current_lang)
	if current_index == -1: current_index = 0
	
	var raw_list = GameData.current_records
	# Filtramos records del nivel actual
	var level_list : Array[LevelRecord] = []
	for rec in raw_list:
		if rec.level_id == viewing_level_id:
			level_list.append(rec)
	
	var text_times := ""
	var text_dates := ""
	var text_hours := ""
	
	if level_list.is_empty():
		text_times = list_empty_string[current_index]
		text_dates = ""
		text_hours = ""
	else:
		# Duplicamos el array y lo reordenamos al revés, el último queda arriba
		var splash_record_list = level_list.duplicate()
		splash_record_list.reverse()
		for rec in splash_record_list:
			# Creamos un string formateado TIEMPO:
			var time_formatted = "%.2f" % rec.time_record
			# Lo añadimos a el string final
			text_times += "* " + time_formatted + "\n"
			
			text_dates += rec.get_date_string() + "\n"
			text_hours += rec.get_hour_string() + "\n"
	
	# Actualizamos label
	label_times_record.text = text_times
	label_day_record.text = text_dates
	label_hour_record.text = text_hours
	
"""

#region Buttons!!!
func _on_button_next_pressed():
	if (_current_index + 1) < level_info_array_ordered.size():
		_current_index += 1
		_show_info(level_info_array_ordered[_current_index])
		h_box_container.alignment = BoxContainer.ALIGNMENT_CENTER
		h_box_container.global_position.y = h_box_container.global_position.y -20


func _on_button_previous_pressed():
	if not (_current_index -1) < 0:
		_current_index -= 1
		_show_info(level_info_array_ordered[_current_index])
		h_box_container.alignment = BoxContainer.ALIGNMENT_CENTER
		h_box_container.global_position.y = h_box_container.global_position.y -20

func _on_button_play_pressed():
	LoadBar.fade_to_scene(level_info_array_ordered[_current_index].level_path)

func _on_button_prev_menu_pressed():
	hide_level_info()
