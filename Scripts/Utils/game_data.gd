extends Node
class_name GamePersistentData

# Aquí podemos ir alterando el array para añadir capas como fecha del record, hora, etc
var current_records : Array[LevelRecord] = []
var _pending_coins : Array[CoinData] = []

const save_path = "user://save_game.res"

func _ready() -> void:
	load_data()

# Se llama desde CoinCollectable al recoger
func register_coin(level_id: int, material: CoinData.CoinMaterial) -> void:
	var coin := CoinData.new()
	coin.set_data(level_id, material)
	_pending_coins.append(coin)

func add_record(level_id : int, new_time : float):
	var new_record = LevelRecord.new()
	new_record.set_data(level_id, new_time)
	
	# Transferimos solo las monedas de este nivel 
	for coin in _pending_coins:
		if coin.level_id == level_id: 
			new_record.coins_collected.append(coin)
	_pending_coins.clear()
	
	current_records.append(new_record)
	_clean_old_records(level_id)
	_save_to_disk()

# Verificar si es necesario, me lo recomendó IA
func discard_pending_coins() -> void: _pending_coins.clear()

func _clean_old_records(target_level_id : int):
	# Contamos cuántos records hay en este nivel
	var records_of_this_level : Array[LevelRecord] = []
	for rec in current_records:
		if rec.level_id == target_level_id:
			records_of_this_level.append(rec)
	# Borramos al superar 9
	if records_of_this_level.size() > 9:
		# Ordenamos de mayor a menor tiempo y luego eliminamos el primero (mayor tiempo)
		records_of_this_level.sort_custom(func(a, b): return a.time_record > b.time_record)
		current_records.erase(records_of_this_level[0])

func _save_to_disk():
	var save = SaveData.new()
	save.records = current_records
	ResourceSaver.save(save, save_path)

func load_data():
	if ResourceLoader.exists(save_path):
		var save = load(save_path)
		
		if save:
			current_records = save.records
