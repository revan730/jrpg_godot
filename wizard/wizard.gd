extends Node2D

@onready var teleportData = get_node("/root/TeleportData")

func _ready():
	match teleportData.teleported_from:
		teleportData.Teleports.TOWN_WIZARD:
			$player.global_position = $teleport_from_town.global_position


func _process(delta):
	pass


func _on_town_tp_body_entered(body):
	teleportData.teleported_from = teleportData.Teleports.WIZARD_TOWN
	get_tree().change_scene_to_file("res://town/town.tscn")
