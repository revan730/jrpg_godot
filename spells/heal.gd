extends Spell

class_name Heal

func _init():
	self.name = "Heal"
	self.cost = 50
	self.mp = 5
	self.info = "Heal 5 MP"
	self.char = PartyMember.Character.Healer
	self.side = SpellSide.Sides.Player
