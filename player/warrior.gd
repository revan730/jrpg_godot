extends PartyMember

class_name Warrior

func _init():
	self.name = "Cid"
	self.role = "Warrior"
	var portrait: Texture2D = preload("res://player/portrait_warrior.png")
	self.battle_sprite = Sprite2D.new()
	self.battle_sprite.texture = preload("res://player/left_2.png")
	self.battle_sprite.scale = Vector2(4, 4)
	self.intelligence = 10
	self.strength = 10
	self.dexterity = 15
	self.durability = 15
	self.hp_multiplier = 2
	self.mp_multiplier = 1
	self.dmg_multiplier = 1
	self.exp_multiplier = 10
	self.int_increment = 1
	self.str_increment = 1
	self.dex_increment = 2
	self.dur_increment = 2
	self.recalculate_stats()
