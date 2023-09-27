extends Usable

class_name ManaPotion

func _init():
	self.item_name = "Mana potion"
	self.cost = 50
	self.info = "Restores 20 MP"

func apply_effect(target): # TODO: Type
	target.mp += 20
