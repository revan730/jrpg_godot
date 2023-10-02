extends Node2D

class_name WorldMapManager

signal toggle_game_paused(is_paused: bool)
signal toggle_inventory_opened(is_opened: bool)
signal toggle_party_info_opened(is_opened: bool)
signal toggle_trader_opened(is_opened: bool)

var game_paused: bool = false:
	get:
		return game_paused
	set(value):
		game_paused = value
		get_tree().paused = value
var inventory_opened: bool = false
var party_info_opened: bool = false
var trader_opened: bool = false


func _input(event):
	if (event.is_action_pressed("pause")):
		if !inventory_opened and !party_info_opened and !trader_opened:
			var paused: bool = get_tree().paused
			game_paused = !paused
		emit_signal("toggle_game_paused", game_paused) # Rename signal to toggle_main_menu_opened or something like
	elif (event.is_action_pressed("toggle_inventory") and !party_info_opened and !trader_opened):
		var paused: bool = get_tree().paused
		game_paused = !paused
		inventory_opened = game_paused
		emit_signal("toggle_inventory_opened", game_paused)
	elif (event.is_action_pressed("toggle_party_info") and !inventory_opened and !trader_opened):
		var paused: bool = get_tree().paused
		game_paused = !paused
		party_info_opened = game_paused
		emit_signal("toggle_party_info_opened", game_paused)
		


func _on_trader_body_entered(_body):
	if !inventory_opened and !trader_opened:
		var paused: bool = get_tree().paused
		game_paused = !paused
		trader_opened = game_paused
		emit_signal("toggle_trader_opened", game_paused)


func _on_trader_closed():
	game_paused = false
	trader_opened = false
