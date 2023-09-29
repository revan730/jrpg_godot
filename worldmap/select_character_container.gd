extends PanelContainer

signal character_selected(character: PartyMember)
signal selection_canceled

@onready var playerParty = get_node("/root/PlayerParty")
@onready var character_list = get_node("MarginContainer/HBoxContainer/character_list")

	
func reload_character_list():
	character_list.clear()
	for character in playerParty.members:
		character_list.add_item(character.name)
	character_list.select(0)

func _ready():
	character_list.allow_search = false
	hide()
	self.reload_character_list()

func _on_character_list_item_activated(index):
	character_selected.emit(playerParty.members[index])
	hide()

func _on_inventory_container_open_character_select(caller: Control):
	show()
	character_list.grab_focus()
	
func _input(event):
	if self.visible:
		if event.is_action_pressed("ui_cancel"):
			hide()
			selection_canceled.emit()
			# TODO: Emit signal to inventory to regrab focus
