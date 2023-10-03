extends PanelContainer

signal closed

@export var worldMapManager: WorldMapManager

@onready var playerParty = get_node("/root/PlayerParty")
@onready var inventory_items_list = get_node("MarginContainer/VBoxContainer/inventory_items")
@onready var item_description_label = get_node("MarginContainer/VBoxContainer/description_and_gold/item_description")
@onready var gold_label = get_node("MarginContainer/VBoxContainer/description_and_gold/gold_value")
@onready var message_box = get_tree().get_root().get_child(2).find_child("gui").find_child("message_box") # TODO: Hardcoded, fix

var wizard_stock: Array[Spell] = [Fireball.new(), Lightning.new()]


func reload_inventory_items():
	inventory_items_list.clear()
	for item in wizard_stock:
		inventory_items_list.add_item(item.to_string())
	if inventory_items_list.item_count > 0:
		inventory_items_list.select(0)
	if wizard_stock.size() > 0:
		item_description_label.text = wizard_stock[0].info
	else:
		item_description_label.text = "N/A"
	gold_label.text = str(playerParty.gold)
	
func _ready():
	inventory_items_list.allow_search = false
	hide()
	self.reload_inventory_items()
	worldMapManager.connect("toggle_wizard_opened", _on_world_manager_toggle_wizard_opened)

func regrab_focus():
	inventory_items_list.grab_focus()
	
func buy_item(index):
	var spell = wizard_stock[index]
	if playerParty.gold >= spell.cost:
		wizard_stock.remove_at(index)
		playerParty.add_spell(spell)
		playerParty.gold -= spell.cost
	else:
		inventory_items_list.release_focus()
		message_box.text = "Not enough gold"
		message_box.display()
		message_box.connect("closed", _on_message_box_closed)

func _on_world_manager_toggle_wizard_opened(is_opened: bool):
	if (is_opened):
		show()
		self.regrab_focus()
	else:
		hide()

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		hide()
		closed.emit()

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


func _on_inventory_items_item_activated(index):
	self.buy_item(index)
	self.reload_inventory_items()


func _on_inventory_items_item_selected(index):
	item_description_label.text = wizard_stock[index].info
