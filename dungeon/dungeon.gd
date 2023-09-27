extends Node2D


@onready var teleportData = get_node("/root/TeleportData")

func _ready():
	match teleportData.teleported_from:
		teleportData.Teleports.OVERWORLD_DUNGEON_NORTH:
			$player.global_position = $teleport_from_north.global_position
		teleportData.Teleports.OVERWORLD_DUNGEON_SOUTH:
			$player.global_position = $teleport_from_south.global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_first_island_tp_body_entered(_body):
	teleportData.teleported_from = teleportData.Teleports.DUNGEON_NORTH
	get_tree().change_scene_to_file("res://overworld/overworld.tscn")


func _on_second_island_tp_body_entered(_body):
	teleportData.teleported_from = teleportData.Teleports.DUNGEON_SOUTH
	get_tree().change_scene_to_file("res://overworld/overworld.tscn")
