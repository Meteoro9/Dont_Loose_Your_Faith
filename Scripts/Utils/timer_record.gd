extends Label
class_name TimerRecord

var current_time := 0.0
var started := false

func _ready() -> void:
	current_time = 0.0
	text = "0.00"

func _process(delta: float) -> void:
	if not started:
		if Input.is_anything_pressed():
			started = true
	
	if started:
		current_time += delta
		text = "%.2f" % current_time
