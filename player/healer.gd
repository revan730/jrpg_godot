extends PartyMember

class_name Healer

func _init():
	self.name = "Rilay"
	self.intelligence = 15
	self.strength = 5
	self.dexterity = 10
	self.durability = 5
	self.hp_multiplier = 1
	self.mp_multiplier = 2
	self.dmg_multiplier = 1
	self.exp_multiplier = 12
	self.int_increment = 2
	self.str_increment = 1
	self.dex_increment = 1
	self.dur_increment = 2
	self.recalculate_stats()
	# TODO: Spells