extends PartyMember

class_name Healer

func reload_battle_sprite():
	self.battle_sprite = Sprite2D.new()
	self.battle_sprite.texture = preload("res://player/battle_idle_healer.png")
	self.battle_sprite.scale = Vector2(4, 4)

func _init():
	self.name = "Rilay"
	self.role = "Healer"
	self.spells.append(Heal.new())
	self.portrait = preload("res://player/portrait_healer.png")
	self.reload_battle_sprite()
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
