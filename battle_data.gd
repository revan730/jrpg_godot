extends Node

static var npc_party: Array[Npc] = []
static var defeated_npcs: Array[Npc] = []
static var previous_scene: String = ''
static var enemy_placement_to_remove: String
static var removed_placements_dungeon: Array[String]
static var player_party_placement: Vector2
static var return_from_battle: bool = false

static var bg_texture: Texture2D:
	get:
		return bg_texture
	set(value):
		bg_texture = value

func remove_dead_npcs():
	var dead_npcs = npc_party.filter(func(n: Npc): return n.hp == 0)
	defeated_npcs.append_array(dead_npcs)
	npc_party = npc_party.filter(func(n: Npc): return n.hp > 0)
	
func after_battle_cleanup():
	defeated_npcs.clear()
	npc_party.clear()

func set_battle_npcs(npcs: Array[Npc]):
	npc_party = npcs

func enter_battle(player_party_placement: Vector2, remove_enemy: String, npcs: Array[Npc]):
	self.player_party_placement = player_party_placement
	enemy_placement_to_remove = remove_enemy
	self.set_battle_npcs(npcs)
	previous_scene = get_tree().current_scene.scene_file_path
	get_tree().change_scene_to_file("res://battle/battle.tscn")
