extends PartyMember

class_name Ranger

func _init():
	self.name = "Jaden"
	self.intelligence = 10
	self.strength = 15
	self.dexterity = 10
	self.durability = 10
	self.hp_multiplier = 2
	self.mp_multiplier = 1
	self.dmg_multiplier = 2
	self.exp_multiplier = 10
	self.int_increment = 1
	self.str_increment = 2
	self.dex_increment = 2
	self.dur_increment = 1
	self.recalculate_stats()
