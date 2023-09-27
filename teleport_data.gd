extends Node

enum Teleports {
	 OVERWORLD_TOWN,
	 TOWN_OVERWORLD,
	 TOWN_TRADER,
	 TRADER_TOWN,
	 TOWN_WIZARD,
	 WIZARD_TOWN,
	 OVERWORLD_DUNGEON_NORTH,
	 OVERWORLD_DUNGEON_SOUTH,
	 DUNGEON_NORTH,
	 DUNGEON_SOUTH,
	 OVERWORLD_SAND_DUNGEON_NORTH,
	 OVERWORLD_SAND_DUNGEON_SOUTH,
	 SAND_DUNGEON_NORTH,
	 SAND_DUNGEON_SOUTH,
	 }

static var teleported_from: Teleports:
	get:
		return teleported_from
	set(value):
		teleported_from = value


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
