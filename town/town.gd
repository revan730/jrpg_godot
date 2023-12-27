extends Node2D

@onready var teleportData = get_node("/root/TeleportData")

# Called when the node enters the scene tree for the first time.
func _ready():
	if (teleportData.position_from_save):
		$player.global_position = teleportData.position_from_save
		teleportData.position_from_save = Vector2.ZERO
		get_tree().paused = false
	else:
		match teleportData.teleported_from:
			teleportData.Teleports.OVERWORLD_TOWN:
				$player.global_position = $teleport_from_overworld.global_position
			teleportData.Teleports.TRADER_TOWN:
				$player.global_position = $teleport_from_trader.global_position
			teleportData.Teleports.WIZARD_TOWN:
				$player.global_position = $teleport_from_wizard.global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_overworld_tp_body_entered(_body):
	teleportData.teleported_from = teleportData.Teleports.TOWN_OVERWORLD
	get_tree().change_scene_to_file("res://overworld/overworld.tscn")


func _on_trader_tp_body_entered(_body):
	teleportData.teleported_from = teleportData.Teleports.TOWN_TRADER
	get_tree().change_scene_to_file("res://trader/trader.tscn")


func _on_wizard_tp_body_entered(body):
	teleportData.teleported_from = teleportData.Teleports.TOWN_WIZARD
	get_tree().change_scene_to_file("res://wizard/wizard.tscn")
