extends Area2D
class_name CoinCollectable

@export var coin_material : CoinData.CoinMaterial
@export var level_id : int
var was_picked := false

func _ready() -> void:
	match coin_material:
		CoinData.CoinMaterial.GOLD: $AnimatedSprite2D.play("Gold")
		CoinData.CoinMaterial.SILVER: $AnimatedSprite2D.play("Silver")
		CoinData.CoinMaterial.BRONZE: $AnimatedSprite2D.play("Bronze")
	body_entered.connect(_collect)
	show()

func _collect(body: Node2D): 
	if body is CandlePlayer and not was_picked: 
		was_picked = true
		GameData.register_coin(level_id, coin_material)
		hide()
