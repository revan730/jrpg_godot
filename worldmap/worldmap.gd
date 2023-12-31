extends Node2D

class_name WorldMapManager

@onready var playerParty = get_node("/root/PlayerParty")
@onready var battleData = get_node("/root/BattleData")
@onready var teleportData = get_node("/root/TeleportData")
@onready var saveLoadManager = get_node("/root/SaveLoadManager")

signal toggle_game_paused(is_paused: bool)
signal toggle_inventory_opened(is_opened: bool)
signal toggle_party_info_opened(is_opened: bool)
signal toggle_trader_opened(is_opened: bool)
signal toggle_wizard_opened(is_opened: bool)
signal toggle_save_load_opened(is_opened: bool)

var game_paused: bool = false:
	get:
		return game_paused
	set(value):
		game_paused = value
		var scene_tree = get_tree()
		if scene_tree:
			scene_tree.paused = value
var inventory_opened: bool = false
var party_info_opened: bool = false
var trader_opened: bool = false
var wizard_opened: bool = false
var save_load_menu_opened: bool = false


func _input(event):
	if (event.is_action_pressed("pause")):
		if !inventory_opened and !party_info_opened and !trader_opened and !save_load_menu_opened:
			var paused: bool = get_tree().paused
			game_paused = !paused
		emit_signal("toggle_game_paused", game_paused) # Rename signal to toggle_main_menu_opened or something like
		if save_load_menu_opened:
			self.close_save_load_menu()
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
	if !inventory_opened and !party_info_opened and !trader_opened:
		var paused: bool = get_tree().paused
		game_paused = !paused
		trader_opened = game_paused
		emit_signal("toggle_trader_opened", game_paused)


func _on_trader_closed():
	game_paused = false
	trader_opened = false


func _on_wizard_body_entered(_body):
	if !inventory_opened and !party_info_opened and !wizard_opened:
		var paused: bool = get_tree().paused
		game_paused = !paused
		wizard_opened = game_paused
		emit_signal("toggle_wizard_opened", game_paused)


func _on_wizard_closed():
	game_paused = false
	wizard_opened = false
	
func open_save_load_menu():
	save_load_menu_opened = true
	emit_signal("toggle_save_load_opened", true)
	emit_signal("toggle_game_paused", false)
	
func close_save_load_menu():
	emit_signal("toggle_save_load_opened", false)

func save_game(slot_num: int):
	var scene_serialized = self.serialize_for_save()
	saveLoadManager.save_game(slot_num, scene_serialized)
	
func load_game(slot_num: int):
	saveLoadManager.load_game(slot_num)

func serialize_for_save():
	return {
		"scene": get_tree().current_scene.scene_file_path,
		"player_pos": { "x": $level/player.global_position.x, "y": $level/player.global_position.y }
	}

func _on_load_save_menu_container_closed():
	save_load_menu_opened = false


func _on_load_save_menu_container_load(save_slot):
	self.load_game(save_slot)
	game_paused = false
	self.close_save_load_menu()

func _on_load_save_menu_container_save(save_slot):
	self.save_game(save_slot)
	game_paused = false
	self.close_save_load_menu()
