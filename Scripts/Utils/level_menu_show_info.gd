extends Control
class_name LevelShowInfo

@export var times_record_label : Label
@export var day_record_label : Label
@export var hour_record_label : Label
@export var stars_record_label : Label
@export var level_info_array_ordered : Array[LevelSummaryMenu]
var _current_index := 0
@export var h_box_container : HBoxContainer

func _ready() -> void:
	await get_tree().create_timer(1.0).timeout
	_show_info(level_info_array_ordered[0])
	h_box_container.alignment = BoxContainer.ALIGNMENT_CENTER
	h_box_container.global_position.y = h_box_container.global_position.y -20

func _show_info(summary: LevelSummaryMenu) -> void:
	var times_text := ""
	var day_text := ""
	var hour_text := ""
	var stars_text := ""
	
	for entry in summary.processed_records:
		times_text += "*" + entry["time"] + "\n"
		day_text += entry["date"] + "\n"
		hour_text += entry["hour"] + "\n"
		stars_text += "★".repeat(entry["stars"]) + "☆".repeat(5 - entry["stars"]) + "\n"
	
	times_record_label.text = times_text
	day_record_label.text = day_text
	hour_record_label.text = hour_text
	stars_record_label.text = stars_text


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
	pass
