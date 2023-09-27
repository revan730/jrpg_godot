"""
Represents armor item class for inventory
"""
extends Item

class_name Armour

var def: int

func _init():
	# Default values
	self.item_name = "Coat"
	self.def = 2
	self.cost = 10
	self.info = "Simple coat"

func _to_string():
	return "%s (+%s)" % self.item_name % self.def

