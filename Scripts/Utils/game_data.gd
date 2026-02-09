extends Node
class_name GamePersistentData

const SAVE_PATH := "user://save.tres"
const MAX_RECORDS_PER_LEVEL := 9

var data: SaveData


func _ready() -> void:
	load_data()

func _get_level(level_id: String) -> LevelData:
	for level in data.levels:
		if level.level_id == level_id:
			return level
	return null

func add_time(level_id: String, new_time: float) -> void:
	var level := _get_level(level_id)
	
	if level == null:
		level = LevelData.new()
		level.level_id = level_id
		data.levels.append(level)
	
	var record := RecordData.new()
	record.time = new_time
	
	var datetime := Time.get_datetime_dict_from_system()
	record.day = "%04d-%02d-%02d" % [
		datetime.year,
		datetime.month,
		datetime.day
	]
	record.hour = "%02d:%02d:%02d" % [
		datetime.hour,
		datetime.minute,
		datetime.second
	]
	
	level.records.append(record)
	
	if level.records.size() > MAX_RECORDS_PER_LEVEL:
		level.records.pop_front()
	
	save_data()


func save_data() -> void:
	ResourceSaver.save(data, SAVE_PATH)


func load_data() -> void:
	if ResourceLoader.exists(SAVE_PATH):
		data = load(SAVE_PATH) as SaveData
		if data == null:
			data = SaveData.new()
	else:
		data = SaveData.new()

func get_records(level_id: String) -> Array[RecordData]:
	var level := _get_level(level_id)
	if level:
		return level.records
	return []
