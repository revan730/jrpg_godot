extends Node

class_name PlayerPartyData

static var inventory_items: Array[Item] = [HealthPotion.new(), FireBlade.new(), StoneArmour.new()]
static var gold: int = 1000
static var members: Array[PartyMember] = [Warrior.new(), Mage.new(), Healer.new(), Ranger.new()]
