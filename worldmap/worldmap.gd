extends Node2D

class_name WorldMapManager

signal toggle_game_paused(is_paused: bool)
signal toggle_inventory_opened(is_opened: bool)

var game_paused: bool = false:
	get:
		return game_paused
	set(value):
		game_paused = value
		get_tree().paused = value
var non_pause_menu_opened: bool = false


func _input(event):
	if (event.is_action_pressed("pause")):
		if !non_pause_menu_opened:
			var paused: bool = get_tree().paused
			game_paused = !paused
		emit_signal("toggle_game_paused", game_paused) # Rename signal to toggle_main_menu_opened or something like
	elif (event.is_action_pressed("toggle_inventory")):
		var paused: bool = get_tree().paused
		game_paused = !paused
		non_pause_menu_opened = game_paused
		emit_signal("toggle_inventory_opened", game_paused)
