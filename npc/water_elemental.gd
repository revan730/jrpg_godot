extends Npc

class_name WaterElemental

func _init():
	super("Water Elemental", 40, 0, 20, 10, 10, [],[])
	self.battle_sprite = Sprite2D.new()
	self.battle_sprite.texture = preload("res://npc/water_elemental_battle_idle.png")
	self.battle_sprite.scale = Vector2(4, 4)

func decide(player_party: Array[PartyMember], npc_party: Array[Npc]):
	if player_party.size() > 0:
		return self.attack(player_party[randi() % player_party.size()])
