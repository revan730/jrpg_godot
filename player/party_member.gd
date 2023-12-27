"""
Represents base game class to be derived by actual classes like Warrior
"""

class_name PartyMember

var role: String
var name: String
var portrait: Texture2D = preload("res://player/portrait_warrior.png")
var battle_sprite: Sprite2D
var level: int = 1
var max_level: int = 25
var hp: int
var max_hp: int
var mp: int
var max_mp: int
var damage: int
var defence: int
var evasion: int
var spells: Array[Spell]
var armour: Armour = preload("res://items/armour.gd").new()
var weapon: Weapon = preload("res://items/weapon.gd").new()
var experience: int:
	get:
		return experience
	set(value):
		experience = value
		if value > up_experience:
			self.level_up()
var up_experience: int
var intelligence: int
var strength: int
var dexterity: int
var durability: int
var int_increment: int
var str_increment: int
var dex_increment: int 
var dur_increment: int
var hp_multiplier: int
var mp_multiplier: int
var dmg_multiplier: int
var exp_multiplier: int
var base_evasion: float = 0.05

enum Character {
	Warrior,
	Mage,
	Healer,
	Ranger
}

func level_up():
	var levels_upped = 0
	while self.experience >= self.up_experience:
		self.level += 1
		self.up_experience = self.level * self.exp_multiplier
		levels_upped += 1
	self.intelligence += self.int_increment * levels_upped
	self.strength += self.str_increment * levels_upped
	self.dexterity += self.dex_increment * levels_upped
	self.durability += self.dur_increment * levels_upped
	self.recalculate_stats()
	
func recalculate_stats():
	self.max_hp = self.durability * self.hp_multiplier
	self.hp = self.max_hp
	self.max_mp = self.intelligence * self.mp_multiplier
	self.mp = self.max_mp
	self.damage = self.strength * self.dmg_multiplier + self.weapon.dmg
	self.defence = self.armour.def
	self.evasion = self.base_evasion * self.dexterity / 10

func heal(amount):
	if self.hp > 0:
		self.hp += amount
		if self.hp > self.max_hp:
			self.hp = self.max_hp

func apply_damage(amount: int):
	if self.hp > 0:
		if randf() > self.evasion:
			return false
		else:
			var dmg = amount - self.defence
			if dmg <= self.hp:
				self.hp -= dmg
			else:
				self.hp = 0

func apply_magic_damage(amount: int):
	if self.hp > 0:
		if self.hp >= amount:
			self.hp -= amount
		else:
			self.hp = 0

func add_exp(exp: int):
	experience += exp
	if experience >= up_experience:
		level_up()

func set_weapon(weapon: Weapon):
	self.weapon = weapon
	self.recalculate_stats()

func set_armour(armour: Armour):
	self.armour = armour
	self.recalculate_stats()
	

func serialize_for_save():
	var spells_serialized = []
	for s in spells:
		spells_serialized.append(s.get_script().get_path())
		
	return {
		"class_path": self.get_script().get_path(),
		"spells": spells_serialized,
		"armour": armour.get_script().get_path(),
		"weapon": weapon.get_script().get_path(),
		"experience": experience
	}
