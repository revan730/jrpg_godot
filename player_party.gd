extends Node

class_name PlayerPartyData

static var inventory_items: Array[Item] = [HealthPotion.new(), FireBlade.new(), StoneArmour.new()]
static var gold: int = 1000
static var members: Array[PartyMember] = [Warrior.new(), Mage.new(), Healer.new(), Ranger.new()]

func reload_battle_sprites():
	for m in members:
		m.reload_battle_sprite()

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
		
func add_exp(exp: int):
	for m in members:
		m.add_exp(exp)
		
func serialize_members():
	var serialized = []
	for m in members:
		serialized.append(m.serialize_for_save())
	
	return serialized

func serialize_for_save():
	var inventory_items_serialized = []
	for i in inventory_items:
		inventory_items_serialized.append(i.get_script().get_path())
	return {
		"inventory_items": inventory_items_serialized,
		"gold": gold,
		"members": self.serialize_members()
	}

func load_from_save(data):
	gold = data.gold
	inventory_items.clear()
	for i in data.inventory_items:
		var item = load(i).new()
		inventory_items.append(item)
	# TODO: Reset inventory item list in inventory UI
	members.clear()
	for m in data.members:
		var member = load(m.class_path).new()
		member.experience = m.experience
		member.armour = load(m.armour).new()
		member.weapon = load(m.weapon).new()
		member.spells.clear()
		for s in m.spells:
			member.spells.append(load(s).new())
		members.append(member)
	print_debug(members)
