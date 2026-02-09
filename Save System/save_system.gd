extends Resource
class_name SaveData

@export var records : Array[float] = []

func save_times(times_to_save : Array):
	records = times_to_save
	

func load_times() -> Array: 
	return records
