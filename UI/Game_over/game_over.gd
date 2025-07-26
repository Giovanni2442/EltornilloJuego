extends TileMapLayer

@onready var Game_over = $Control/GameOverContainer
@onready var Game_highRecord = $Control/GameHighScore 
@onready var vlInpt = $Control/GameHighScore/MessageLabel/HBoxContainer/LineEdit

var config_file = ConfigFile.new() 
	
# FUNCIÓN PARA GUARDAR EL RECORD DEL JUGADOR
func record_update(score):
	# -- SISTEMA DE PREMIOS -- #
	if Game.record != 0:
		if Game.score > Game.record:
			Game.record = Game.score
			guardar()
			
		if Game.score >= 20 and Game.score <= 30:
			addNewPlayer("player_3")
		elif Game.score >= 30 and Game.score <= 55:
			addNewPlayer("player_2")
		elif Game.score >= 55:
			addNewPlayer("player_1")
		else:
			$Control/GameOverContainer.visible = true
	else : 			 
		Game.record = score
		$Control/GameOverContainer.visible = true
		print(" --> : ",Game.record)
		guardar()

# -------------------------- ELEMENTOS DE PRUEBAS ---------------------------------- # 
	# !!ADVERTENCIA FUNCIÓN DE PRUEBAS!! #
func record(score):							# PUNTAJE DEL JUGADOR
	if Game.record !=0 :					# MIENTRAS EL RECORD NO SEA 'CERO'
		if Game.score > Game.record:
			Game.record = Game.score
			guardar()						# GUARDAR EL NUEVO RECORD	
		if Game.score >= 1:	
			print("aqui!!!!")				
			addNewPlayerPru("player_1")
		else:
			$Control/GameOverContainer.visible = true
			
	elif Game.score != 0:
		print("Record vacio!")
		Game.record = score
		$Control/GameHighScore.visible = true
		print(" --> : ",Game.record)
		guardar()
		addNewPlayerPru("panch0")
	else : 
		$Control/GameOverContainer.visible = true


func addNewPlayerPru(typPlyr):	
	var err = config_file.load("user://partida_guardada.cfg")		# CAEGAR LOS ELEMENTOS DEL ARCHIVO
	if err != OK:		# VERIFICA LA EXISTENICIA DEL ARCHIVO 
		print("No se encuentra el archivo! : ",err)
		#config_file.save("user://players.cfg")
		return
	else : 
		'''config_file.set_value("Player","name","Panch0_pru")
		config_file.set_value("Player","score","25")
		config_file.save("user://partida_guardada.cfg")'''
		
		var elmnts = Array(config_file.get_sections())
		#print(" -Sz-> : ",elmnts.size()," : ",elmnts.filter(func(i): return "player" in i.to_lower()))
		
		if elmnts.size() == 1:										# -- SIN JUGADORES -- #
			$Control/GameHighScore.visible = true					# AGREGA EL NUEVO JUGADOR, ESPERANDO EL BOTON
			Game.type_player = "Player_1"
		#else:
			# DEL ARCHIVO, TOMA LOS ELEMENTOS QUE CONTENGAN LA PALABRA "PLAYER"
		var players = Array(config_file.get_sections()).filter(func(plyr): return "player" in plyr.to_lower())
		print(players)
		for i in players:
			for j in config_file.get_section_keys(i):
				var valor = config_file.get_value(i,"score")
				print(" -x-> : ",valor)
				
		'''if elmnts.has(typPlyr):
			var score = config_file.get_value(typPlyr,"score")
			if Game.score > score:
				$Control/GameHighScore.visible = true
				Game.type_player = typPlyr		# ASIGNA EL TIPO DE JUGADOR O SU POSICIÓN	
			else:
				$Control/GameOverContainer.visible = true	
		else:
			$Control/GameHighScore.visible = true
			Game.type_player = typPlyr
			#config_file.set_value("player_1","name",)	
				
		print(config_file.get_sections())
		'''
		
# ------------------------------------------------------------------- # 

# -- AGREGAR EL TOP 3 -- #
func addNewPlayer(typPlyr):
	var err = config_file.load("user://partida_guardada.cfg")
	if err != OK:		# VERIFICA LA EXISTENICIA DEL ARCHIVO 
		print("No se encuentra el archivo! : ",err)
	else : 
		var elmnts = config_file.get_sections()
		if elmnts.has(typPlyr):
			var score = config_file.get_value(typPlyr,"score")
			if Game.score > score:
				$Control/GameHighScore.visible = true
				Game.type_player = typPlyr		# ASIGNA EL TIPO DE JUGADOR O SU POSICIÓN	
			else:
				$Control/GameOverContainer.visible = true	
		else:
			$Control/GameHighScore.visible = true
			Game.type_player = typPlyr
			#config_file.set_value("player_1","name",)	
				
		print(config_file.get_sections())
				
# --- ESTA FUNCIÓN SE AGREGARA EN EL MENU PRINCIPAL PARA OBTENER LOS DATOS --- 
func cargar():
	config_file = ConfigFile.new()
	var error = config_file.load("user://partida_guardada.cfg")
	if error != OK:
		print("no hay una partida guardada!")
	else: 
		Game.record = config_file.get_value("record","record",0)	
		
# GUARDA EL NUEVO RECORD OBTENIDO POR EL USUARIO
func guardar():
	#config_file = ConfigFile.new()
	#config_file.set_value("record","usser","GioXd")
	config_file.set_value("record","record",Game.record)
	config_file.save("user://partida_guardada.cfg")
	
# ------------------------------------------ SEÑALES DE PRUEBA BOTONES ----------------------------------------- #

#  -- VERIFICAR Y AÑADIR EL NUEVO JUGADOR -- 
func _on_texture_button_pressed():
	var nameUsr = $Control/GameHighScore/MessageLabel/HBoxContainer/LineEdit.text
	if $Control/GameHighScore.visible == true:
		if len(nameUsr) != 0:	
			config_file.set_value(Game.type_player,"name",nameUsr)
			config_file.set_value(Game.type_player,"score",Game.score)
			config_file.save("user://partida_guardada.cfg")		
	Game.new_game.emit()
		
	'''if $Control/GameHighScore.visible == true:
		var vlueInpt = $Control/GameHighScore/MessageLabel/HBoxContainer/LineEdit
		# GUARDAR JUGADOR Y RE-COMENZAR JUEGO
		if len(vlueInpt.text) != 0:			#VERIFICA SI EL CAMPO ESTA LLENO
			print(" --> : ",vlInpt.text)
			
			#config_file.set_value(vlueInpt.text,"name","Player_void")
			#config_file.set_value(,"score",0)
		else : 
			Game.damage
			print("vacio el ped0")
		
		#config_fil
	'''

# ------------------------------- #
func _ready():
	#cargar()
	pass
	#record.text = str(Game.record)
