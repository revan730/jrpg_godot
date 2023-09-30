"""
Represents base game class to be derived by actual classes like Warrior
"""

class_name PartyMember

var role: String
var name: String
var portrait: Texture2D = preload("res://player/portrait_warrior.png")
var level: int = 1
var max_level: int = 25
var hp: int
var max_hp: int
var mp: int
var max_mp: int
var damage: int
var defence: int
var evasion: int
# TODO: Spells
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

func level_up():
	self.level += 1
	self.up_exp = self.level * self.exp_multiplier
	self.intelligence += self.int_increment
	self.strength += self.str_increment
	self.dexterity += self.dex_increment
	self.durability += self.dur_increment
	self.recalculate_stats()
	
func recalculate_stats():
	self.max_hp = self.durability * self.hp_multiplier
	self.hp = self.max_hp
	self.max_mp = self.intelligence * self.mp_multiplier
	self.mp = self.max_mp
	self.damage = self.strength * self.dmg_multiplier + self.weapon.dmg
	self.defence = self.armour.def
	self.evasion = self.base_evasion * self.dexterity / 10

