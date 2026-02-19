extends Label
class_name TimerRecord

var current_time := 0.0
var started := false
var finished := false

func _ready() -> void:
	current_time = 0.0
	text = "0.00"
	
	var fire = get_parent().get_parent().get_node("Candle-Player/FireArea")
	if fire: fire.fire_killed.connect(stop_timer)

func _process(delta: float) -> void:
	if not started:
		if Input.is_anything_pressed():
			started = true
	
	if started and not finished:
		current_time += delta
		text = "%.2f" % current_time

func stop_timer():
	finished = true
