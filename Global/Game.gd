extends Node
# --- SIGNALS AND GLOBAL ELEMNETS OF GAME --- #
signal play_game
signal new_game
signal game_over
signal main_menu

#---PLAYER---
var speed := 425
var auxPlyr = []		# VARIABLE AUXILIAR
var auxPlyrDict = {}

#---ITEMS---#
var score := 0
var damage := 0
var record := 0
var type_player := ""

#---DROP VELODITY TO ITEMS---·
var drop_velodity_scrap := 0
