"""
Defines basic NPC class for battle state
"""

class_name Npc

var name: String
var battle_sprite: Sprite2D
var hp: int
var max_hp: int
var mp: int
var max_mp: int
var dmg: int
var loot: Array[Dictionary]
var exp: int # Experience points which every player character gets for defeating this NPC
var gold: int # Gold for defeating this NPC
var spells: Array[Spell]

func _init(name: String, hp: int, mp: int, dmg: int, exp: int, gold: int, loot: Array[Dictionary], spells: Array[Spell]):
	self.name = name
	self.hp = hp
	self.max_hp = hp
	self.mp = mp
	self.max_mp = mp
	self.dmg = dmg
	self.exp = exp
	self.gold = gold
	self.loot = loot
	self.spells = spells

func decide(player_party: Array[PartyMember], npc_party: Array[Npc]):
	"""
	Method which is called when npc must decide what to do on it's turn
	:param player_party: player party object
	:param npc_party: list of npc party members
	"""
	pass
	
func apply_damage(dmg: int):
	if dmg > self.hp:
		self.hp = 0
	else:
		self.hp -= dmg

func attack(target: PartyMember):
	var damaged = target.apply_damage(self.dmg)
	var status = ""
	if !damaged:
		status = "%s dodged %s's damage" % [target.name, self.name]
	else:
		status = "%s dealt %s damage to %s" % [self.name, self.dmg, target.name]
	
	return status

func cast_spell(spell: Spell, target: PartyMember):
	self.mp -= spell.mp
	spell.apply(target)
	return "%s casted %s on %s" % [self.name, spell.name, target.name]

func get_loot() -> Array[Item]:
	var dropped_loot: Array[Item] = []
	for i in self.loot:
		var chance = randf()
		if chance >= i.rate:
			dropped_loot.append(i.item)
	
	return dropped_loot
