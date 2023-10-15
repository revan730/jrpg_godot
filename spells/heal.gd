extends Spell

class_name Heal

func _init():
	self.name = "Heal"
	self.cost = 50
	self.mp = 5
	self.info = "Heal 5 MP"
	self.char = PartyMember.Character.Healer
	self.side = SpellSide.Sides.Player

func check_applicable(target):
	return target.hp != 0 and target.hp < target.max_hp
	
func apply(target):
	target.heal(5)
