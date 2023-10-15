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
