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
var projectile_texture: Texture2D

func _to_string():
	return "%s (%s MP)" % [name, mp]

func apply(target):
	pass
