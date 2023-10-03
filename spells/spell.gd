"""
Represents spell, which can be applied to characters
"""

class_name Spell

var name: String
var cost: int
var info: String
var mp: int
var char: PartyMember.Character
var side: SpellSide.Sides

func _to_string():
	return "%s (%s MP)" % [name, mp]
