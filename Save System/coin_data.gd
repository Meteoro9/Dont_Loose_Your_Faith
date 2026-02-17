extends Resource
class_name CoinData

enum CoinMaterial { GOLD, SILVER, BRONZE }
@export var material : CoinMaterial
@export var level_id : int

func set_data(p_level_id: int, p_material: CoinMaterial) -> void:
	level_id = p_level_id
	material = p_material
