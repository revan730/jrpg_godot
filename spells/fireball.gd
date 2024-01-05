extends Spell

class_name Fireball

func _init():
	self.name = "Fireball"
	self.cost = 50
	self.mp = 10
	self.info = "Deal 15 points of damage"
	self.char = PartyMember.Character.Mage
	self.side = SpellSide.Sides.NPC
	self.projectile_texture = preload("res://projectiles/fireball.png")

func check_applicable(target: Npc):
	return true
	
func apply(target: Npc):
	target.apply_damage(15)
