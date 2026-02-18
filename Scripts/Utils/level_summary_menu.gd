extends Node
class_name LevelSummaryMenu

# Agregar acá los niveles para poder seleccionarlos.
# Level_0 = Sample_Level, no mostrarlo en versión final
enum LevelSelected { LEVEL_0, LEVEL_1, LEVEL_3 } 
@export var level_id : LevelSelected = LevelSelected.LEVEL_0
@export var level_path : String

@export var gold_coins_limit : int = 0
@export var silver_coins_limit : int = 0
@export var bronze_coins_limit : int = 0

# Tiempos necesarios para las estrellas dadas por tiempo
@export var time_star_1: float = 30.0
@export var time_star_2: float = 25.0

# Info procesada para mostrar en pantalla
var processed_records: Array[Dictionary] = []

func _ready() -> void:
	var raw_list: Array[LevelRecord] = GameData.current_records
	var levels_list: Array[LevelRecord] = _filter_level_records(raw_list)
	processed_records = _build_display_data(levels_list)

# Filtramos records solo para el nivel correspondiente actual
func _filter_level_records(raw: Array[LevelRecord]) -> Array[LevelRecord]:
	var result: Array[LevelRecord]
	for rec in raw:
		if rec.level_id == level_id:
			result.append(rec)
	result.reverse()
	return result

# Guardamos el diccionario que pasará la info para mostrarse en pantalla
func _build_display_data(records: Array[LevelRecord]) -> Array[Dictionary]:
	var result: Array[Dictionary] = []
	for rec in records:
		var stars := _count_stars(rec)
		result.append({
			"time": "%.2f" % rec.time_record,
			"date": rec.get_date_string(),
			"hour": rec.get_hour_string(),
			"stars": stars
		})
	return result

# Procesamos estrellas
func _count_stars(rec: LevelRecord) -> int:
	var stars := 0
	# Filtramos según coleccionables del nivel
	if gold_coins_limit > 0 and rec.get_coins_by_material(CoinData.CoinMaterial.GOLD) >= gold_coins_limit:
		stars += 1
	if silver_coins_limit > 0 and rec.get_coins_by_material(CoinData.CoinMaterial.SILVER) >= silver_coins_limit:
		stars += 1
	if bronze_coins_limit > 0 and rec.get_coins_by_material(CoinData.CoinMaterial.BRONZE) >= bronze_coins_limit:
		stars += 1
	# Filtramos según tiempos necesarios
	if rec.time_record < time_star_1:
		stars += 1
	if rec.time_record < time_star_2:
		stars += 1
	
	return stars
