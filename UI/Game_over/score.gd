extends Label
# MUESTRA LA PUNTUACIÓN EN EL LABEL
func  _ready():
	text = str(Game.score)
