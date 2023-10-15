"""
Represents usable item like potion, which applies some effect to user
"""

extends Item

class_name Usable

func _to_string():
	return "%s (%s G)" % [item_name, cost]
	
func apply_effect(target: PartyMember):
	"""
	apply item effect on it's target
	:param target: player party member
	"""
	pass

func check_applicable(target: PartyMember):
	pass
