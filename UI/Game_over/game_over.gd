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
		
		#var auxPlyr = []
		
		print(" -LNG-> " , len(players))
		print(" -SZ-> " , players.size())
		
		# -- AGREGAR PRIMER SCORE -- #
		if players.size() == 0:
			Game.type_player = new_player + str(players.size())
			return
		
		# -- AGREGAR TOP 3 JUGADORES -- #
		if players.size() != 3:
			#Game.type_player = new_player + str(players.size())
			#$Control/GameHighScore.visible = true 
			
			var b1						# VARIABLE AUXILIAR
			
			for i in players:			# RECORRE LOS JUGADORES DEL ARREGLO		
				print("xxxxxxx : ",i)
				#print(" -Scre-> : ",Game.score)
				# NOTA : COMIENZA EN '1' , YA QUE EL ELEMENTO '0' ES EL SCORE GLOBAL DEL JUEGO
				
				#for j in range(1,config_file.get_section_keys(i).size()): 
				var valor = config_file.get_value(i,"score")
				print(" -x-> : ",valor)
				
				if Game.score > valor:
					#Game.auxPlyr.append(i)
					#Game.auxPlyr.append(config_file.get_value(i,"name")) 
					#Game.auxPlyr.append(config_file.get_value(i,"score"))
					Game.auxPlyrDict[i] = { 'name' : config_file.get_values(i,"name"), 'score' : config_file.get_value(i,"score") }
							
					b1 = true
					break
						
						#scrAux.append("")
						#b1 = true
						#break
			if !b1:
				Game.type_player = new_player + str(players.size())
			else :
				#var j=Game.auxPlyr.get(0)
				for j in range(Game.auxPlyr.get(0),players) :
					print(j)
					Game.auxPlyrDict[j] = { 'name' : config_file.get_values(j,"name") }
			
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
			print("NO HAY CUPO XD")
			
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

func savaPlayer(index,nombre,score):
	config_file.set_value(index,"name",nombre)
	config_file.set_value(index,"score",score)
	config_file.save("user://partida_guardada.cfg")	

#  -- VERIFICAR Y AÑADIR EL NUEVO JUGADOR -- 
func _on_texture_button_pressed():	
	var nameUsr = $Control/GameHighScore/MessageLabel/HBoxContainer/LineEdit.text
	print(" -Dic-> : ",Game.auxPlyrDict)
	
	if Game.auxPlyr.size() != 0:
		savaPlayer(Game.auxPlyr.get(0),nameUsr,Game.score)
		
		'''config_file.set_value(Game.auxPlyr.get(0),"name",nameUsr)
		config_file.set_value(Game.auxPlyr.get(0),"score",Game.score)
		config_file.save("user://partida_guardada.cfg")	'''
	
		if $Control/GameHighScore.visible == true:
			if len(nameUsr) != 0:
				savaPlayer(Game.type_player,Game.auxPlyr.get(1),Game.auxPlyr.get(2))	
				
				'''config_file.set_value(Game.type_player,"name",Game.auxPlyr.get(1))
				config_file.set_value(Game.type_player,"score",Game.auxPlyr.get(2))
				config_file.save("user://partida_guardada.cfg")'''
				
		Game.auxPlyr.clear()	
		Game.new_game.emit()
	else:
		if $Control/GameHighScore.visible == true:
			if len(nameUsr) != 0:	
				config_file.set_value(Game.type_player,"name",nameUsr)
				config_file.set_value(Game.type_player,"score",Game.score)
				config_file.save("user://partida_guardada.cfg")
		Game.new_game.emit()
	
	'''
	var nameUsr = $Control/GameHighScore/MessageLabel/HBoxContainer/LineEdit.text
	if $Control/GameHighScore.visible == true:
		if len(nameUsr) != 0:	
			config_file.set_value(Game.type_player,"name",nameUsr)
			config_file.set_value(Game.type_player,"score",Game.score)
			config_file.save("user://partida_guardada.cfg")		
	Game.new_game.emit()
	'''

	
	
	

# ------------------------------- #
func _ready():
	#cargar()
	pass
	#record.text = str(Game.record)
