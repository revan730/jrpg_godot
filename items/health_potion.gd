extends Usable

class_name HealthPotion

func _init():
	self.item_name = "Health potion"
	self.cost = 50
	self.info = "Restores 20 HP"

func apply_effect(target):
	target.heal(20)
	
func check_applicable(target):
	return target.hp > 0 and target.hp < target.max_hp
