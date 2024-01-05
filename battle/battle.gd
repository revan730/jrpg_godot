extends Node2D

@onready var battleData = get_node("/root/BattleData")
@onready var playerParty = get_node("/root/PlayerParty") # TODO: snake_case
@onready var party_members_list = get_node("ui/VBoxContainer/HBoxContainer/player_party/MarginContainer/party_members_list")
@onready var enemy_list = get_node("ui/VBoxContainer/HBoxContainer/enemies/MarginContainer/enemy_list")
@onready var action_menu = get_node("ui/VBoxContainer/HBoxContainer/actions")
@onready var action_attack_btn = get_node("ui/VBoxContainer/HBoxContainer/actions/MarginContainer/VBoxContainer/attack_btn")
@onready var action_spells_btn = get_node("ui/VBoxContainer/HBoxContainer/actions/MarginContainer/VBoxContainer/magic_btn")
@onready var action_items_btn = get_node("ui/VBoxContainer/HBoxContainer/actions/MarginContainer/VBoxContainer/item_btn")
@onready var action_log = get_node("ui/VBoxContainer/actions_log_bar/MarginContainer/action")
@onready var items_window = get_node("ui/VBoxContainer/HBoxContainer/items")
@onready var items_list = get_node("ui/VBoxContainer/HBoxContainer/items/MarginContainer/items_list")
@onready var spells_window = get_node("ui/VBoxContainer/HBoxContainer/spells")
@onready var spells_list = get_node("ui/VBoxContainer/HBoxContainer/spells/MarginContainer/spells_list")

enum PlayerSelectionActions {
	Attack,
	Spell,
	Item
}

var current_player_character = -1
var current_npc = -1
var npc_turn = false
var last_player_selection_action = null

func wait(time: float):
	var t = Timer.new()
	t.set_wait_time(time)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	await t.timeout
	t.queue_free()
	

func reload_party_members_list():
	party_members_list.clear()
	for member in playerParty.members:
		party_members_list.add_item("%s    %s/%s HP %s/%s MP" % [member.name, member.hp, member.max_hp, member.mp, member.max_mp])
		if member.hp == 0:
			party_members_list.set_item_custom_fg_color(party_members_list.item_count - 1, Color("#ff0000"))

func remove_children(node: Node, ignore_child: String):
	for child in node.get_children():
		if ignore_child and child.name == ignore_child:
			continue
		node.remove_child(child)
		
func reload_party_member_sprites():
	var placements = get_tree().get_nodes_in_group("player_placements")
	for p in placements:
		if p.get_child_count() > 0:
			self.remove_children(p, "")
	
	var alive_members = playerParty.get_alive()
	for i in range(alive_members.size()):
		placements[i].add_child(alive_members[i].battle_sprite)

func reload_enemy_sprites():
	var placements = get_tree().get_nodes_in_group("enemy_placements")
	for p in placements:
		if p.get_child_count() > 0:
			self.remove_children(p, "collision_area") # Only removing sprites so collision areas are left intact
	for i in range(battleData.npc_party.size()):
		placements[i].add_child(battleData.npc_party[i].battle_sprite)
	
func reload_enemy_list():
	battleData.remove_dead_npcs()
	enemy_list.clear()
	for member in battleData.npc_party:
		enemy_list.add_item("%s    %s/%s HP %s/%s MP" % [member.name, member.hp, member.max_hp, member.mp, member.max_mp])
		

func select_npc():
	var next_character = null
	if current_npc < battleData.npc_party.size() - 1:
		current_npc += 1
		next_character = battleData.npc_party[current_npc]
	if !next_character:
		print_debug("Passing control to Player")
		npc_turn = false
		current_npc = -1
		self.next_turn()
	else:
		enemy_list.deselect_all()
		enemy_list.select(current_npc)
		print_debug("Before wait")
		await self.wait(2.0)
		print_debug("After wait")
		action_log.text = next_character.decide(playerParty.get_alive(), battleData.npc_party)
		print_debug(action_log.text)
		self.reload_party_members_list()
		self.reload_party_member_sprites()
		self.next_turn()

func select_player_character():
	var next_character = null
	while current_player_character + 1 < playerParty.members.size():
		current_player_character += 1
		if playerParty.members[current_player_character].hp > 0:
			next_character = playerParty.members[current_player_character]
			break
	if !next_character and playerParty.is_anyone_alive():
		print_debug("Passing control to NPCs")
		npc_turn = true
		current_player_character = -1
		return await self.next_turn()
	elif !next_character and !playerParty.is_anyone_alive():
		get_tree().change_scene_to_file("res://game_over/game_over.tscn")
	
	action_menu.visible = true
	action_attack_btn.grab_focus()
	party_members_list.select(current_player_character)
	

func _ready():
	playerParty.reload_battle_sprites()
	self.reload_party_members_list()
	self.reload_party_member_sprites()
	self.reload_enemy_list()
	self.reload_enemy_sprites()
	self.select_player_character()
	
func load_spells_window(spells: Array[Spell]):
	action_menu.visible = false
	spells_list.clear()
	for s in spells:
		spells_list.add_item(s.name)
	spells_window.visible = true
	spells_list.select(0)
	spells_list.grab_focus()

func load_items_window(items: Array[Item]):
	action_menu.visible = false
	items_list.clear()
	for i in items:
		items_list.add_item(i.item_name)
	items_window.visible = true
	items_list.select(0)
	items_list.grab_focus()
	
func quit_items_window():
	items_window.visible = false
	action_menu.visible = true
	action_items_btn.grab_focus()
	
func quit_spells_window():
	spells_window.visible = false
	action_menu.visible = true
	action_spells_btn.grab_focus()

func _on_flee_btn_pressed():
	if !playerParty.is_everyone_alive():
		action_log.text = "Cannot flee: you have KO'ed members"
	else:
		print_debug("Fleeing from battle")

func quit_item_player_selection():
	party_members_list.select(current_player_character)
	party_members_list.process_mode = Node.PROCESS_MODE_DISABLED
	items_window.visible = true
	items_list.grab_focus()

func quit_spell_player_selection():
	party_members_list.select(current_player_character)
	party_members_list.process_mode = Node.PROCESS_MODE_DISABLED
	spells_window.visible = true
	spells_list.grab_focus()
	
func quit_spell_npc_selection():
	enemy_list.deselect_all()
	enemy_list.process_mode = Node.PROCESS_MODE_DISABLED
	spells_window.visible = true
	spells_list.grab_focus()
	
func quit_attack():
	enemy_list.disconnect("item_activated", action_attack)
	enemy_list.deselect_all()
	enemy_list.process_mode = Node.PROCESS_MODE_DISABLED
	action_menu.visible = true
	action_attack
	action_attack_btn.grab_focus()

func _on_item_btn_pressed():
	var usable_items = playerParty.get_usable_items()
	if usable_items.size() == 0:
		action_log.text = "Party has no usable items"
	else:
		self.load_items_window(usable_items)
		
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if items_window.visible:
			self.quit_items_window()
		if spells_window.visible:
			self.quit_spells_window()
		if party_members_list.process_mode == PROCESS_MODE_ALWAYS:
			if last_player_selection_action == PlayerSelectionActions.Item:
				self.quit_item_player_selection()
			else:
				self.quit_spell_player_selection()
		if enemy_list.process_mode == PROCESS_MODE_ALWAYS:
			if last_player_selection_action == PlayerSelectionActions.Spell:
				self.quit_spell_npc_selection()
			if last_player_selection_action == PlayerSelectionActions.Attack:
				self.quit_attack()

func calculate_loot_gold_exp():
	var loot: Array[Item] = []
	var exp: int = 0
	var gold: int = 0
	for n in battleData.defeated_npcs:
		loot.append_array(n.loot)
		gold += n.gold
		exp += n.exp
	return { "loot": loot, "exp": exp, "gold": gold }

func next_turn():
	if battleData.npc_party.size() == 0:
		print_debug("Victory. Calculating loot etc.")
		action_log.text = "Victory!"
		var loot_gold_exp = self.calculate_loot_gold_exp()
		for i in loot_gold_exp.loot:
			action_log.text = "Received %s!" % i.name
			playerParty.inventory_items.append(i)
			await self.wait(2.0)
		action_log.text = "Received %s gold!" % loot_gold_exp.gold
		await self.wait(2.0)
		action_log.text = "Each party member got %s experience!" % loot_gold_exp.exp
		await self.wait(2.0)
		playerParty.add_exp(loot_gold_exp.exp)
		# TODO: Pause between logs
		playerParty.gold += loot_gold_exp.gold
		battleData.return_from_battle = true
		battleData.after_battle_cleanup()
		get_tree().change_scene_to_file(battleData.previous_scene)
		return
	
	enemy_list.deselect_all()
	party_members_list.deselect_all()
	action_menu.visible = false
	party_members_list.process_mode = Node.PROCESS_MODE_DISABLED
	enemy_list.process_mode = Node.PROCESS_MODE_DISABLED
	if npc_turn:
		print_debug("Npc turn")
		self.select_npc()
	else:
		self.select_player_character()
		
func action_attack(target_index):
	var dmg = playerParty.members[current_player_character].damage
	var npc = battleData.npc_party[target_index]
	npc.apply_damage(dmg)
	action_log.text = "%s dealt %s DMG to %s" % [playerParty.members[current_player_character].name, dmg, npc.name]
	enemy_list.disconnect("item_activated", action_attack)
	self.reload_enemy_list()
	self.reload_enemy_sprites()
	self.next_turn()

func action_spell_player(target_index):
	var character = playerParty.members[target_index]
	await self.action_spell(character, target_index)

func action_spell_npc(target_index):
	var npc = battleData.npc_party[target_index]
	await self.action_spell(npc, target_index)
	
func launch_spell_projectile(source: Node2D, target: Node2D, spell: Spell):
	var projectile_texture = spell.projectile_texture
	assert(projectile_texture, "spell %s doesn't have projectile texture" % spell.name)
	var target_body = target.get_child(0)
	var source_pos = source.position
	var projectile: Projectile = preload("res://projectiles/projectile.tscn").instantiate()
	projectile.position = source_pos
	projectile.set_target(target_body)
	self.add_child(projectile)
	await projectile.target_hit
	projectile.queue_free()
	
func action_spell(npc_or_char, npc_or_char_index):
	print_debug("Applying spell on target %s" % npc_or_char)
	var spell = playerParty.members[current_player_character].spells[spells_list.get_selected_items()[0]]
	if spell.check_applicable(npc_or_char) and playerParty.members[current_player_character].mp >= spell.mp:
		var projectile_caster = get_tree().get_nodes_in_group("player_placements")[current_player_character]
		var projectile_target = get_tree().get_nodes_in_group("enemy_placements")[npc_or_char_index]
		await self.launch_spell_projectile(projectile_caster, projectile_target, spell)
		spell.apply(npc_or_char)
		playerParty.members[current_player_character].mp -= spell.mp
		self.reload_enemy_list()
		self.reload_enemy_sprites()
		self.reload_party_members_list()
		self.reload_party_member_sprites()
		action_log.text = "%s casted %s on %s" % [playerParty.members[current_player_character].name, spell.name, npc_or_char.name]
		self.next_turn()
		
		if npc_or_char is Npc:
			enemy_list.disconnect("item_activated", action_spell_npc)
		else:
			party_members_list.disconnect("item_activated", action_spell_player)
	else:
		action_log.text = "Cannot cast %s on %s" % [spell.name, npc_or_char.name]
	
func action_item(target_index):
	var item = playerParty.get_usable_items()[items_list.get_selected_items()[0]]
	var character = playerParty.members[target_index]
	print_debug("Applying item %s on character %s" % [item.item_name, target_index])
	if item.check_applicable(character):
		item.apply_effect(character)
		self.reload_party_members_list()
		self.reload_party_member_sprites()
		action_log.text = "%s used on %s" % [item.item_name, character.name]
		playerParty.remove_item(item)
		party_members_list.disconnect("item_activated", action_item)
		self.next_turn()
	else:
		action_log.text = "Cannot use %s on %s" % [item.item_name, character.name]

func _on_spells_list_item_activated(index):
	last_player_selection_action = PlayerSelectionActions.Spell
	var selected_spell = playerParty.members[current_player_character].spells[index]
	if playerParty.members[current_player_character].mp >= selected_spell.mp:
		if selected_spell.side == SpellSide.Sides.NPC:
			enemy_list.process_mode = Node.PROCESS_MODE_ALWAYS
			enemy_list.select(0)
			enemy_list.grab_focus()
			enemy_list.connect("item_activated", action_spell_npc)
		else:
			party_members_list.process_mode = Node.PROCESS_MODE_ALWAYS
			party_members_list.grab_focus()
			party_members_list.connect("item_activated", action_spell_player)
		spells_window.visible = false
	else:
		action_log.text = "Not enough mana to cast %s" % selected_spell.name

func _on_items_list_item_activated(index):
	last_player_selection_action = PlayerSelectionActions.Item
	items_window.visible = false
	party_members_list.process_mode = Node.PROCESS_MODE_ALWAYS
	party_members_list.grab_focus()
	party_members_list.connect("item_activated", action_item)

func _on_magic_btn_pressed():
	if playerParty.members[current_player_character].spells.size() > 0:
		self.load_spells_window(playerParty.members[current_player_character].spells)
	else:
		action_log.text = "%s has no spells :(" % playerParty.members[current_player_character].name

func _on_attack_btn_pressed():
	last_player_selection_action = PlayerSelectionActions.Attack
	action_menu.visible = false
	enemy_list.process_mode = Node.PROCESS_MODE_ALWAYS
	enemy_list.select(0)
	enemy_list.grab_focus()
	enemy_list.connect("item_activated", action_attack)
