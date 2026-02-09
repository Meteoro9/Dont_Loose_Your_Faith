extends Node
class_name GamePersistentData

# Aquí podemos ir alterando el array para añadir capas como fecha del record, hora, etc
var records : Array[float] = []

func _ready() -> void:
	load_data()

func add_time(new_time : float):
	records.append(new_time)
	
	if records.size() > 9:
		records.pop_front()
	
	var save = SaveData.new()
	save.save_times(records)
	ResourceSaver.save(save, "user://save.res")

func load_data():
	if ResourceLoader.exists("user://save.tres"):
		var save = load("user://save.res")
		
		if save:
			records = save.records
