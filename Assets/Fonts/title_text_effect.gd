@tool
extends RichTextEffect
class_name TitleTextEffect

var bbcode = "title-effect"

const FIRE_COLORS = [
	Color(0.8, 0.1, 0.0),  
	Color("ff2900ff"),
	Color("ff4d00ff"),  
	Color(1.0, 0.6, 0.0),   
	Color(1.0, 0.706, 0.0, 1.0),  
]

func _process_custom_fx(char_fx: CharFXTransform) -> bool:
	var t: float = char_fx.elapsed_time
	var index: float = char_fx.range.x # Posión del carácter dentro del texto
	
	# variación de tiempo para independencia de respiración de letras
	var offset: float = index * 0.4
	# onda que va de 0.0 a 1.0
	var wave: float = (sin(t * 2.5 + offset) + 1.0) / 2.0
	
	# multiplicamos los segmentos por la cantidad de colores -0
	var segmentos: int = FIRE_COLORS.size() -1
	var pos: float = wave * segmentos
	
	var from: int = int(pos)
	var to: int = min(from +1, segmentos)
	var blend: float = pos - from # fracción entre ambos colores
	
	char_fx.color = FIRE_COLORS[from].lerp(FIRE_COLORS[to], blend)
	
	# efecto de respiración vertical sutil
	char_fx.offset.y -= sin(t * 2.5 + offset) * 1.5
	
	return true
