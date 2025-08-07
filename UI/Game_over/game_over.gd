extends TileMapLayer

@onready var Game_over = $Control/GameOverContainer
@onready var Game_highRecord = $Control/GameHighScore 
@onready var vlInpt = $Control/GameHighScore/MessageLabel/HBoxContainer/LineEdit

# HACEDER AL ARCHIVO PARA EL REGISTRO DE USUARIOS
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
func record(score):									# PUNTAJE DEL JUGADOR
	# YA EXISTE POR LO MENOS UN JUGADOR
	if Game.record !=0 :							# MIENTRAS EL RECORD NO SEA 'CERO'
		# -- SUPERO EL RECORD!! --
		if Game.score > Game.record:
			Game.record = Game.score				# ASIGNA A RECORD EL SCORE DEL JUGADOR PREVIO
			guardar()								# GUARDAR EL NUEVO RECORD	
			$Control/GameHighScore.visible = true 	# AGREGAR EL JUGADOR CON EL NUEVO PUNTAJE 
			addNewPlayerPru(true)
			return
		
		# -- VERIFICAR SU POSICIÓN!! --
		if Game.score >= 1:	
			print("VERIFICA POSICION!!!!")				
			addNewPlayerPru(false)				# *** COMPRUEBA SI REBASO A UN JUGADOR REGISTRADO *** #
		else:
			$Control/GameOverContainer.visible = true
			
	elif Game.score != 0:							# *** REGISTRA EL PRIMER JUGADOR *** 
		print("Record vacio!")
		Game.record = score
		$Control/GameHighScore.visible = true
		print(" --> : ",Game.record)
		guardar()
		addNewPlayerPru(false)
	else : 
		$Control/GameOverContainer.visible = true

# ADD NEWPLAYER TO THE FILE 
func addNewPlayerPru(record_superado):	
	var err = config_file.load("user://partida_guardada.cfg")		# CAEGAR LOS ELEMENTOS DEL ARCHIVO
	if err != OK:		# VERIFICA LA EXISTENICIA DEL ARCHIVO 
		print("No se encuentra el archivo! : ",err)
		#config_file.save("user://players.cfg")
		return
	else : 
		
		
		var elmnts = Array(config_file.get_sections())			# NUMERO DE ELEMENTOS EN EL ARCHIVO
		var new_player = "player_"
		var players = Array(config_file.get_sections()).filter(func(plyr): return "player" in plyr.to_lower())
		
		print(" -LNG-> " , len(players))
		print(" -SZ-> " , players.size())
		
		# -- AGREGAR PRIMER SCORE -- #
		if players.size() == 0:
			Game.type_player = new_player + str(players.size())
			return
		
		# -- AGREGAR TOP 3 JUGADORES -- #
		if players.size() != 3:
			Game.type_player = new_player + str(players.size())
			$Control/GameHighScore.visible = true 
			return
			
			'''if record_superado:
				Game.type_player = new_player + str(players.size())
			else:
				print("pues perdio alv")
				$Control/GameOverContainer.visible = true
			'''
				
		else:
			# --- VERIFICAR POCICIÓNAMIENTO --- #
			#$Control/GameOverContainer.visible = true
			#print("NO HAY CUPO XD")
			for i in players:			# RECORRE LOS JUGADORES DEL ARREGLO		
				print(i)
				#print("-pEd0 -> : ",config_file.get_section_keys(i))	
				for j in range(1,config_file.get_section_keys(i).size()):
					var valor = config_file.get_value(i,"score")
					print(" -x-> : ",valor)
					#if Game.score > valor:
					#	pass
			
			
			
		'''
		# REGISTRA EL USUARIO QUE SUPERO EL RECORD
		if players.size() != 4:
			if record_superado:
				Game.type_player = "player_"+str(players.size()) 
				
			else:
				
				
		else:
			pass
		#print(" -Sz-> : ",elmnts.size()," : ",elmnts.filter(func(i): return "player" in i.to_lower()))
		
		# -- PRIMER JUGADOR -- 
		if elmnts.size() == 1:										# -- SIN JUGADORES -- #
			$Control/GameHighScore.visible = true					# AGREGA EL NUEVO JUGADOR, ESPERANDO EL BOTON
			Game.type_player = "Player_0"
			
		else:
			# DEL ARCHIVO, TOMA LOS ELEMENTOS QUE CONTENGAN LA PALABRA "PLAYER"
			#var players = Array(config_file.get_sections()).filter(func(plyr): return "player" in plyr.to_lower())
			print(players.size())	
			
			# -- NUEVO JUGADOR --
			Game.type_player = "player_"+str(players.size())
			
			#if players.size() != 4:			# VERIFICA SI EXISTEN 3 JUGADORES EN EL ARCHIVO
			for i in players:			# RECORRE LOS JUGADORES DEL ARREGLO		
				print(i)
				#print("-pEd0 -> : ",config_file.get_section_keys(i))	
				for j in range(1,config_file.get_section_keys(i).size()):
					var valor = config_file.get_value(i,"score")
					print(" -x-> : ",valor)
					#if Game.score > valor:
					#	pass
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
