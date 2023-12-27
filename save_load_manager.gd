extends Node

@onready var playerParty = get_node("/root/PlayerParty")
@onready var battleData = get_node("/root/BattleData")
@onready var teleportData = get_node("/root/TeleportData")

func save_game(slot_num: int, serialized_world):
	var save_data = {
		"party": playerParty.serialize_for_save(),
		"battleData": battleData.serialize_for_save(),
		"teleportData": teleportData.serialize_for_save(),
		"scene": serialized_world
	}
	
	print_debug(playerParty.serialize_for_save())
	print_debug(battleData.serialize_for_save())
	print_debug(teleportData.serialize_for_save())
	print_debug(serialized_world)
	
	var save_file = "user://%s.save" % slot_num
	var file_handle = FileAccess.open(save_file, FileAccess.WRITE)
	var json = JSON.new()
	file_handle.store_line(json.stringify(save_data))
	file_handle.close()
	
func load_game(slot_num: int):
	var save_file = "user://%s.save" % slot_num
	var file_handle = FileAccess.open(save_file, FileAccess.READ)
	# TODO: Handle the case when there is no file
	var json_data = file_handle.get_as_text()
	var json = JSON.new()
	var save_data = json.parse_string(json_data)
	print_debug(save_data)
	
	battleData.load_from_save(save_data.battleData)
	teleportData.load_from_save(save_data.teleportData)
	playerParty.load_from_save(save_data.party)
	teleportData.position_from_save = Vector2(save_data.scene.player_pos.x, save_data.scene.player_pos.y)
	get_tree().change_scene_to_file(save_data.scene.scene)
