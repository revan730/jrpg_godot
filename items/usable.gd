"""
Represents usable item like potion, which applies some effect to user
"""

extends Item

class_name Usable

func _to_string():
	return "%s (%s G)" % self.item_name % self.cost
	
func apply_effect(target: Npc):
	"""
	apply item effect on it's target
	:param target: player or enemy party member
	"""
	pass

func check_applicable(target: Npc):
	pass
