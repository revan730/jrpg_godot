extends PanelContainer

@export var worldMapManager: WorldMapManager

signal open_character_select(caller: Control)

@onready var playerParty = get_node("/root/PlayerParty")
@onready var inventory_items_list = get_node("MarginContainer/VBoxContainer/inventory_items")
@onready var item_description_label = get_node("MarginContainer/VBoxContainer/description_and_gold/item_description")
@onready var gold_label = get_node("MarginContainer/VBoxContainer/description_and_gold/gold_value")
@onready var message_box = get_tree().get_root().get_child(2).find_child("gui").find_child("message_box") # TODO: Hardcoded, fix

func reload_inventory_items():
	inventory_items_list.clear()
	for item in playerParty.inventory_items:
		inventory_items_list.add_item(item.to_string())
	inventory_items_list.select(0)
	item_description_label.text = playerParty.inventory_items[0].info
	self.update_gold_count()
	
func update_gold_count():
	gold_label.text = str(playerParty.gold)

func _ready():
	inventory_items_list.allow_search = false
	hide()
	self.reload_inventory_items()
	worldMapManager.connect("toggle_inventory_opened", _on_world_manager_toggle_inventory_opened)
	
func character_dialog():
	open_character_select.emit(self)

func apply_selection(index: int, item: Item, character: PartyMember):
	if item is Weapon:
		playerParty.inventory_items[index] = character.weapon
		character.weapon = item
		print_debug("Character weapon is now %s" % character.weapon.item_name)
	
func choose_item(index: int):
	print_debug("Choosing item with index %s" % index)
	var item = playerParty.inventory_items[index] # TODO: Possible out of bounds
	if item is Usable:
		# TODO: Remake: Instead of message box this item must be greyed out and unselectable
		inventory_items_list.release_focus()
		message_box.text = "Only for battle"
		message_box.display()
		message_box.connect("closed", _on_message_box_closed)
	else:
		self.character_dialog()

func _on_world_manager_toggle_inventory_opened(is_opened: bool):
	if (is_opened):
		show()
		self.update_gold_count()
		self.regrab_focus()
	else:
		hide()

func regrab_focus():
	inventory_items_list.grab_focus()

func _on_inventory_items_item_activated(index):
	self.choose_item(index)


func _on_inventory_items_item_selected(index):
	item_description_label.text = playerParty.inventory_items[index].info


func _on_select_character_container_selection_canceled():
	self.regrab_focus()

func _on_select_character_container_character_selected(character):
	self.apply_selection(inventory_items_list.get_selected_items()[0], playerParty.inventory_items[inventory_items_list.get_selected_items()[0]], character)
	self.reload_inventory_items()
	self.regrab_focus() # TODO: Probably better to simply reuse other signal from character selection screen not to duplicate this call?
	
func _on_message_box_closed():
	message_box.disconnect("closed", _on_message_box_closed)
	var t = Timer.new()
	t.set_wait_time(0.1)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	await t.timeout
	t.queue_free()
	self.regrab_focus()
