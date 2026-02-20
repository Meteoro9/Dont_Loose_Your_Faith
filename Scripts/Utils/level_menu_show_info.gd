extends Control
class_name LevelShowInfo

@export var times_record_label : Label
@export var day_record_label : Label
@export var hour_record_label : Label
@export var stars_record_label : Label
@export var level_index_label : RichTextLabel

@export var level_info_array_ordered : Array[LevelSummaryMenu]
var current_level_index := 0
@export var h_box_container : HBoxContainer
@export var animation : AnimationPlayer

var languages: Array[String] = ["en_US", "es_AR", "pt_BR", "zh_CN", "ja_JP", "ru_RU", "gn_PY", "fr_FR", "hi_IN"]
var current_lang := "en_US"

func _ready() -> void:
	animation.play("init")
	await get_tree().create_timer(1.0).timeout
	show_info(level_info_array_ordered[0])

func show_info(summary: LevelSummaryMenu) -> void:
	current_lang = TranslationServer.get_locale()
	var current_lang_index = languages.find(current_lang)
	if current_lang_index == -1: current_lang_index = 0
	
	level_index_label.text = tr("LEVEL-TITLE") % current_level_index
	
	var times_text := ""
	var day_text := ""
	var hour_text := ""
	var stars_text := ""
	
	if summary.processed_records.is_empty():
		times_text = tr("NO-RECORDS")
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

#region Animations
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
#endregion

#region Buttons!!!
func _on_button_next_pressed():
	if (current_level_index + 1) < level_info_array_ordered.size():
		current_level_index += 1
		show_info(level_info_array_ordered[current_level_index])

func _on_button_previous_pressed():
	if not (current_level_index -1) < 0:
		current_level_index -= 1
		show_info(level_info_array_ordered[current_level_index])

func _on_button_play_pressed():
	LoadBar.fade_to_scene(level_info_array_ordered[current_level_index].level_path)

func _on_button_prev_menu_pressed():
	hide_level_info()
#endregion
