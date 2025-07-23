extends Node
var config_file = ConfigFile.new()
var err = config_file.load("user://partida_guardada.cfg")

func control():
	#Game.main_menu.connect(mainMenu)
	Game.play_game.connect(playLevel)
		
func playLevel():
	get_tree().change_scene_to_file("res://level/main.tscn")

func mainMenu():
	print("Conactar al menu")
	get_tree().change_scene_to_file("res://main/Main_menu.tscn")

# MUESTRA EL TOP 3 DE JUGADORES CON EL MEJOR RECORD
func _on_score_btn_pressed() -> void:
	if err != OK:
		print("No se cargo el archivo : ",err)
	else :			
		print(config_file.get_sections())		
		for player in config_file.get_sections():
			print(player)

func record():
	pass
'''
if err == OK:
	for usuario in config.get_sections():
		print("Usuario:", usuario)
		for clave in config.get_section_keys(usuario):
			var valor = config.get_value(usuario, clave)
			print("   ", clave, ":", valor)
else:
	print("Error al cargar el archivo:", err)
'''


func _ready():
	control()
