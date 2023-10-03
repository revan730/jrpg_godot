extends PanelContainer

@export var worldMapManager: WorldMapManager

@onready var playerParty = get_node("/root/PlayerParty")

@onready var portrait: TextureRect = get_node("MarginContainer/VBoxContainer/portait_name/portrait")
@onready var name_label: Label = get_node("MarginContainer/VBoxContainer/portait_name/VBoxContainer/name")
@onready var class_label: Label = get_node("MarginContainer/VBoxContainer/portait_name/VBoxContainer/class")

@onready var spells_list: ItemList = get_node("MarginContainer/VBoxContainer/stats_container/right_column/spells_list")
@onready var hp_label: Label = get_node("MarginContainer/VBoxContainer/stats_container/left_column/GridContainer/hp_value")
@onready var mp_label: Label = get_node("MarginContainer/VBoxContainer/stats_container/left_column/GridContainer/mp_value")
@onready var level_label: Label = get_node("MarginContainer/VBoxContainer/stats_container/left_column/GridContainer/level_value")
@onready var strength_label: Label = get_node("MarginContainer/VBoxContainer/stats_container/left_column/GridContainer/strength_value")
@onready var dexterity_label: Label = get_node("MarginContainer/VBoxContainer/stats_container/left_column/GridContainer/dexterity_value")
@onready var intelligence_label: Label = get_node("MarginContainer/VBoxContainer/stats_container/left_column/GridContainer/intelligence_value")
@onready var durability_label: Label = get_node("MarginContainer/VBoxContainer/stats_container/left_column/GridContainer/durability_value")
@onready var damage_label: Label = get_node("MarginContainer/VBoxContainer/stats_container/left_column/GridContainer/damage_value")
@onready var defence_label: Label = get_node("MarginContainer/VBoxContainer/stats_container/left_column/GridContainer/defence_value")
@onready var experience_label: Label = get_node("MarginContainer/VBoxContainer/stats_container/left_column/GridContainer/experience_value")

@onready var weapon_label: Label = get_node("MarginContainer/VBoxContainer/stats_container/mid_column/GridContainer/weapon_value")
@onready var armour_label: Label = get_node("MarginContainer/VBoxContainer/stats_container/mid_column/GridContainer/armour_value")


var current_party_member_index: int = 0
var current_party_member: PartyMember

func reload_spells():
	spells_list.clear()
	for spell in current_party_member.spells:
		spells_list.add_item(spell.to_string(), null, false)

func reload_stats():
	hp_label.text = str(current_party_member.hp)
	mp_label.text = str(current_party_member.mp)
	level_label.text = str(current_party_member.level)
	strength_label.text = str(current_party_member.strength)
	dexterity_label.text = str(current_party_member.dexterity)
	intelligence_label.text = str(current_party_member.intelligence)
	durability_label.text = str(current_party_member.durability)
	damage_label.text = str(current_party_member.damage)
	defence_label.text = str(current_party_member.defence)
	experience_label.text = str(current_party_member.experience)

func reload_character_info():
	portrait.texture = current_party_member.portrait
	name_label.text = current_party_member.name
	class_label.text = current_party_member.role
	
func reload_weapon_armour():
	weapon_label.text = str(current_party_member.weapon)
	armour_label.text = str(current_party_member.armour)

func reload_items():
	self.reload_character_info()
	self.reload_spells()
	self.reload_stats()
	self.reload_weapon_armour()

func set_current_party_member():
	current_party_member = playerParty.members[current_party_member_index]

func _ready():
	hide()
	self.set_current_party_member()
	self.reload_items()
	worldMapManager.connect("toggle_party_info_opened", _on_world_manager_toggle_party_info_opened)
	
func _on_world_manager_toggle_party_info_opened(is_opened: bool):
	if (is_opened):
		show()
	else:
		hide()
		
func prev_character():
	if current_party_member_index == 0:
		current_party_member_index = playerParty.members.size() - 1
	else:
		current_party_member_index -= 1
	self.set_current_party_member()
	self.reload_items()

func next_character():
	if current_party_member_index < playerParty.members.size() - 1:
		current_party_member_index += 1
	else:
		current_party_member_index = 0
	self.set_current_party_member()
	self.reload_items()

func _input(event):
	if event.is_action_pressed("right"):
		self.next_character()
	elif event.is_action_pressed("left"):
		self.prev_character()
