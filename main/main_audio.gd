extends AudioStreamPlayer2D
# REPRODUCIR AUDIO MENU 
func _ready():
	play()
	stream.loop = true
