extends Node2D

class_name WorldMapManager

signal toggle_game_paused(is_paused: bool)

var game_paused: bool = false:
	get:
		return game_paused
	set(value):
		game_paused = value
		get_tree().paused = value
		emit_signal("toggle_game_paused", value)


func _input(event):
	if (event.is_action_pressed("pause")):
		var paused: bool = get_tree().paused
		game_paused = !paused
