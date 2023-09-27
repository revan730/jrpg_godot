"""
Represents weapon item class for inventory
"""
extends Item

class_name Weapon

var dmg: int

func _init():
	# Default values
	self.item_name = "Knife"
	self.dmg = 2
	self.cost = 8
	self.info = "Dull knife"

func _to_string():
	return "%s (+%s)" % self.item_name % self.dmg
