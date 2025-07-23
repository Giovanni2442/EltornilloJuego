extends CanvasLayer

@onready var score_label = $Control/VBoxContainer/ScoreLabel
@onready var record = $Control/VBoxContainer/HBoxContainer/Record
var config_file

# ACTUALIZA LA PUNTUACIÓN
func update_score(score):
	score_label.text = str(score)
	#$ScoreLabel.text = str(score)
#DISMINUYE LA BARRA DE SALUD	
func damage(damage):
	$HealthyBarPlayer.value -= damage
#RETORNA LA SALUD DEL JUGADOR ACTUAL
func value_health() -> int:
	return $HealthyBarPlayer.value
#RECUPERAR VIDA
func heal(heal):	
	$HealthyBarPlayer.value += heal
#RESETAR LA BARRA DE SALUD DEL JUGADOR
func restart_health():
	$HealthyBarPlayer.value = 41
	
# -- CARGAR LOS ELEMENTOS GUARDADOS DEL ARCHIVO -- 
func cargar():
	config_file = ConfigFile.new()
	var error = config_file.load("user://partida_guardada.cfg")
	if error != OK:
		print("no hay una partida guardada!")
	else: 
		Game.record = config_file.get_value("record","record",0)
		
func updateScoreRecord():
	cargar()
	record.text = str(Game.record)
			
func _ready():
	#print("Actualizar")
	cargar()
	record.text = str(Game.record)

'''	
#FUNCIÓN PARA GUARDAR EL RECORD DEL JUGADOR
func record_update(score):
	if score > Game.record: 
		Game.record = score
		record.text = str(Game.record) 
		guardar()
		
func cargar():
	config_file = ConfigFile.new()
	var error = config_file.load("user://partida_guardada.cfg")
	if error != OK:
		print("no hay una partida guardada!")
	else: 
		Game.record = config_file.get_value("record","record",0)	
				
func guardar():
	config_file = ConfigFile.new()
	#config_file.set_value("record","usser","GioXd")
	config_file.set_value("record","record",Game.record)
	config_file.save("user://partida_guardada.cfg")
	
func _ready():
	cargar()
	record.text = str(Game.record)
'''
	
