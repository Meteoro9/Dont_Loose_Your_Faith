extends CanvasLayer

@onready var bar = $ProgressBar
@onready var animation = $AnimationPlayer
var current_scene_changing
var loading := false
const init_bar_value := 0.0
var last_progress := 0.0

func _ready() -> void:
	if animation and animation.has_animation("desabled"): animation.play("desabled")
	else: print("AnimationPlayer no encontrado o animación 'desabled' no encontrada")
	if bar: bar.value = 0.0
	hide()

func fade_to_scene(next_scene_route: String) -> void:
	if loading: return # Evitamos duplicaciones de procesos
	loading = true
	last_progress = 0.0
	bar.value = init_bar_value
	
	show()
	
	animation.play("init")
	current_scene_changing = next_scene_route
	ResourceLoader.load_threaded_request(next_scene_route, "")
	

func _process(delta: float) -> void:
	if loading:
		var progress = []
		var loaded_status = ResourceLoader.load_threaded_get_status(current_scene_changing, progress)
		var new_progress = progress[0] * 100.0
		
		if new_progress > last_progress: # Evitamos que retroceda al terminar la carga
			last_progress = new_progress
			bar.value = lerp(bar.value, last_progress, delta * 5)
		
		if loaded_status == ResourceLoader.ThreadLoadStatus.THREAD_LOAD_LOADED:
			#animation.play("loaded") # temporal
			var packed_next_scene = ResourceLoader.load_threaded_get(current_scene_changing)
			await get_tree().create_timer(0.4).timeout
			get_tree().change_scene_to_packed(packed_next_scene)
			current_scene_changing = ""
			loading = false
	# Esta sección causa errores, no la probé pero es la estructura que pensé que podía ayudar
	if last_progress == 100.0:
		animation.play("loaded")
		await animation.animation_finished
		last_progress = 0.0
