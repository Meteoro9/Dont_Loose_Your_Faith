extends Resource
class_name LevelRecord

@export var level_id : int
@export var time_record : float
@export var coins_collected: Array[CoinData] = []

# Fecha y hora comprimidos en int
@export var unix_timestamp : int

# Constructor
func set_data(p_level_id: int, p_time : float):
	level_id = p_level_id
	time_record = p_time
	unix_timestamp = int(Time.get_unix_time_from_system())

# Helper para consultar externamente
func get_coins_by_material(mat: CoinData.CoinMaterial) -> int:
	var count := 0
	for c in coins_collected:
		if c.material == mat:
			count += 1
	return count

func get_date_string() -> String:
	var date_dict = Time.get_datetime_dict_from_unix_time(unix_timestamp)
	return "%02d/%02d/%d" % [date_dict.year, date_dict.month, date_dict.day]

func get_hour_string() -> String:
	var date_dict = Time.get_datetime_dict_from_unix_time(unix_timestamp)
	return "%02d:%02d" % [date_dict.hour, date_dict.minute]
	
# Convertir int a diccionario (no transferible) con:
# Time.get_datetime_dict_from_unix_time(unix_timestamp)
