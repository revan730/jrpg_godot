extends Spell

class_name Lightning

func _init():
	self.name = "Lightning"
	self.cost = 100
	self.mp = 20
	self.info = "Deal 25 points of damage"
	self.char = PartyMember.Character.Mage
	self.side = SpellSide.Sides.NPC
