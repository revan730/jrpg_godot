extends Node

class_name PlayerPartyData

static var inventory_items: Array[Item] = [HealthPotion.new(), FireBlade.new(), StoneArmour.new()]
static var gold: int = 1000
static var members: Array[PartyMember] = [Warrior.new(), Mage.new(), Healer.new(), Ranger.new()]

func add_spell(spell: Spell):
	if members[spell.char]:
		members[spell.char].spells.append(spell)

func get_alive():
	return members.filter(func(m: PartyMember): return m.hp > 0)

func is_anyone_alive():
	for m in members:
		if m.hp > 0:
			return true
	
	return false

func is_everyone_alive():
	for m in members:
		if m.hp == 0:
			return false
	
	return true

func get_usable_items() -> Array[Item]:
	return inventory_items.filter(func(item: Item): return item is Usable)

func remove_item(i: Item):
	var index = inventory_items.find(i)
	if index == -1:
		print_debug("Trying to remove item not found in inventory")
	else:
		inventory_items.remove_at(index)
