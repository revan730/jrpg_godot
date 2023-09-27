extends Node2D


@onready var teleportData = get_node("/root/TeleportData")

func _ready():
	match teleportData.teleported_from:
		teleportData.Teleports.OVERWORLD_SAND_DUNGEON_NORTH:
			$player.global_position = $teleport_from_north.global_position
		teleportData.Teleports.OVERWORLD_SAND_DUNGEON_SOUTH:
			$player.global_position = $teleport_from_south.global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_north_tp_body_entered(body):
	teleportData.teleported_from = teleportData.Teleports.SAND_DUNGEON_NORTH
	get_tree().change_scene_to_file("res://overworld/overworld.tscn")


func _on_south_tp_body_entered(body):
	teleportData.teleported_from = teleportData.Teleports.SAND_DUNGEON_SOUTH
	get_tree().change_scene_to_file("res://overworld/overworld.tscn")
