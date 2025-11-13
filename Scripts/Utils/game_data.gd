extends Node
class_name GamePersistentData

var records : Array[float] = []

func add_time(new_time : float):
	records.append(new_time)
