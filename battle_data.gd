extends Node

static var npc_party: Array[Npc] = []
static var defeated_npcs: Array[Npc] = []

static var bg_texture: Texture2D:
	get:
		return bg_texture
	set(value):
		bg_texture = value

func remove_dead_npcs():
	var dead_npcs = npc_party.filter(func(n: Npc): return n.hp == 0)
	defeated_npcs.append_array(dead_npcs)
	npc_party = npc_party.filter(func(n: Npc): return n.hp > 0)
