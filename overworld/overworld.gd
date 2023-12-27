extends Node2D

@onready var teleportData = get_node("/root/TeleportData")
@onready var playerParty = get_node("/root/PlayerParty")


# Called when the node enters the scene tree for the first time.
func _ready():
	if (teleportData.position_from_save):
		$player.global_position = teleportData.position_from_save
		teleportData.position_from_save = Vector2.ZERO
		get_tree().paused = false
	else:
		match teleportData.teleported_from:
			teleportData.Teleports.TOWN_OVERWORLD:
				$player.global_position = $teleport_from_town.global_position
			teleportData.Teleports.DUNGEON_NORTH:
				$player.global_position = $teleport_from_dungeon_north.global_position
			teleportData.Teleports.DUNGEON_SOUTH:
				$player.global_position = $teleport_from_dungeon_south.global_position
			teleportData.Teleports.SAND_DUNGEON_NORTH:
				$player.global_position = $teleport_from_sand_dng_north.global_position
			teleportData.Teleports.SAND_DUNGEON_SOUTH:
				$player.global_position = $teleport_from_sand_dng_south.global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_town_tp_body_entered(_body):
	teleportData.teleported_from = teleportData.Teleports.OVERWORLD_TOWN
	get_tree().change_scene_to_file("res://town/town.tscn")
	

func _on_dungeon_north_tp_body_entered(body):
	teleportData.teleported_from = teleportData.Teleports.OVERWORLD_DUNGEON_NORTH
	get_tree().change_scene_to_file("res://dungeon/dungeon.tscn")


func _on_dungeon_south_tp_body_entered(body):
	teleportData.teleported_from = teleportData.Teleports.OVERWORLD_DUNGEON_SOUTH
	get_tree().change_scene_to_file("res://dungeon/dungeon.tscn")


func _on_sand_dng_north_tp_body_entered(body):
	teleportData.teleported_from = teleportData.Teleports.OVERWORLD_SAND_DUNGEON_NORTH
	get_tree().change_scene_to_file("res://sand_dungeon/sand_dungeon.tscn")


func _on_sand_dng_south_tp_body_entered(body):
	teleportData.teleported_from = teleportData.Teleports.OVERWORLD_SAND_DUNGEON_SOUTH
	get_tree().change_scene_to_file("res://sand_dungeon/sand_dungeon.tscn")
