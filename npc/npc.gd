"""
Defines basic NPC class for battle state
"""

class_name Npc

var hp: int
var max_hp: int
var mp: int
var max_mp: int
var dmg: int
# TODO: Loot
var exp: int # Experience points which every player character gets for defeating this NPC
var gold: int # Gold for defeating this NPC

func decide():
	"""
	Method which is called when npc must decide what to do on it's turn
	:param player_party: player party object
	:param npc_party: list of npc party members
	"""
	# TODO: Params
	pass
	
func apply_damage(dmg: int):
	if dmg > self.hp:
		# TODO: Implement
		print_debug("I'm dead")
	else:
		self.hp -= dmg

# TODO: attack, cast spell methods?
