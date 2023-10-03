extends Spell

class_name FireBreath

func _init():
	self.name = "Fire breath"
	self.cost = 0
	self.mp = 10
	self.info = "Deal 15 points of damage"
	self.char = 0
	self.side = SpellSide.Sides.Player
