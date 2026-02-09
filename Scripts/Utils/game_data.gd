extends Node
class_name GamePersistentData

# Aquí podemos ir alterando el array para añadir capas como fecha del record, hora, etc
var current_records : Array[LevelRecord] = []
const save_path = "user://save_game.res"

func _ready() -> void:
	load_data()

func add_record(level_id : int, new_time : float):
	var new_record = LevelRecord.new()
	new_record.set_data(level_id, new_time)
	
	current_records.append(new_record)
	
	_clean_old_records(level_id)
	_save_to_disk()

func _clean_old_records(target_level_id : int):
	# Contamos cuántos records hay en este nivel
	var records_of_this_level : Array[LevelRecord] = []
	for rec in current_records:
		if rec.level_id == target_level_id:
			records_of_this_level.append(rec)
	# Borramos al superar 9
	if records_of_this_level.size() > 9:
		var oldest_rec = records_of_this_level[0]
		current_records.erase(oldest_rec)

func _save_to_disk():
	var save = SaveData.new()
	save.records = current_records
	ResourceSaver.save(save, save_path)

func load_data():
	if ResourceLoader.exists(save_path):
		var save = load(save_path)
		
		if save:
			current_records = save.records
