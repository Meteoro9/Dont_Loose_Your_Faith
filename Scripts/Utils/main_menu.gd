extends Control
class_name MainMenu

@onready var label = $Label

func _ready() -> void:
	var final_text = "Tus tiempos: \n"
	
	var record_list = GameData.records
	
	if record_list.is_empty():
		final_text += "(Aún no se registró ningún tiempo)"
	else:
		for record in record_list:
			# Creamos un string formateado
			var time_formatted = "%.2f" % record
			# Lo añadimos a el string final
			final_text += "* " + time_formatted + "\n"
	
	# Actualizamos label
	label.text = final_text
