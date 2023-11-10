extends Node2D


@onready var teleportData = get_node("/root/TeleportData")
@onready var battleData = get_node("/root/BattleData")

func _ready():
	match teleportData.teleported_from:
		teleportData.Teleports.OVERWORLD_DUNGEON_NORTH:
			$player.global_position = $teleport_from_north.global_position
		teleportData.Teleports.OVERWORLD_DUNGEON_SOUTH:
			$player.global_position = $teleport_from_south.global_position
	if battleData.return_from_battle:
		get_node(battleData.enemy_placement_to_remove).queue_free()
		$player.global_position = battleData.player_party_placement
		battleData.removed_placements_dungeon.append(battleData.enemy_placement_to_remove)
		battleData.return_from_battle = false
	if battleData.removed_placements_dungeon.size() > 0:
		for p in battleData.removed_placements_dungeon:
			get_node(p).queue_free()


func _on_first_island_tp_body_entered(_body):
	teleportData.teleported_from = teleportData.Teleports.DUNGEON_NORTH
	get_tree().change_scene_to_file("res://overworld/overworld.tscn")

func _on_second_island_tp_body_entered(_body):
	teleportData.teleported_from = teleportData.Teleports.DUNGEON_SOUTH
	get_tree().change_scene_to_file("res://overworld/overworld.tscn")

func _on_water_elemental_central_room_body_entered(body):
	var npcs: Array[Npc] = [WaterElemental.new(), WaterElemental.new()]
	battleData.enter_battle(body.global_position, $water_elemental_central_room.name, npcs)

func _on_water_elemental_west_room_body_entered(body):
	var npcs: Array[Npc] = [WaterElemental.new(), FireElemental.new()]
	battleData.enter_battle(body.global_position, $water_elemental_west_room.name, npcs)

func _on_fire_elemental_south_room_body_entered(body):
	var npcs: Array[Npc] = [FireElemental.new()]
	battleData.enter_battle(body.global_position, $fire_elemental_south_room.name, npcs)
