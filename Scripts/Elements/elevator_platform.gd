extends AnimatableBody2D
class_name ElevatorBehaviour

var initial_pos : Vector2
@export var final_pos : Vector2
@export var travel_duration : float
@export var waiting : float

func _ready() -> void:
	initial_pos = position
	position = initial_pos # aseguramos posición
	start_elevator()

func start_elevator(): while true: await travel() # loop infinito

func travel() -> void:
	var tween = create_tween() # viajamos
	tween.set_ease(Tween.EASE_IN_OUT) # inicio y final pausado
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "position", final_pos, travel_duration)
	await tween.finished
	# pausamos para volver y reordenamos
	await wait()
	change_positions()

# activamos el timer y lo esperamos
func wait() -> void:
	await get_tree().create_timer(waiting).timeout

# reordenamos el valor para fines prácticos
func change_positions() -> void:
	var i = initial_pos
	initial_pos = final_pos
	final_pos = i
