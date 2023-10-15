extends Npc

class_name FireElemental

func _init():
	super("Fire Elemental", 50, 20, 5, 10, 30, [{ "item": FireBlade.new(), "rate": 0.1 }],[FireBreath.new()])
	# TODO: Loot
	self.battle_sprite = Sprite2D.new()
	self.battle_sprite.texture = preload("res://npc/fire_elemental_battle_idle.png")
	self.battle_sprite.scale = Vector2(4, 4)

func decide(player_party: Array[PartyMember], npc_party: Array[Npc]):
	if player_party.size() > 0:
		player_party.sort_custom(func(member_a, member_b): return member_a.hp < member_b.hp)
		var min_member = player_party[0]
		if self.mp >= self.spells[0].mp:
			return self.cast_spell(self.spells[0], min_member)
		else:
			return self.attack(min_member)
