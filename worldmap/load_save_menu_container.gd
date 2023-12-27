extends PanelContainer

@export var worldMapManager: WorldMapManager
@onready var save_slots_list = get_node("MarginContainer/VBoxContainer/save_slots_list")

signal load(save_slot: int)
signal save(save_slot: int)
signal open_save_load_select(caller: Control)
signal closed

func _ready():
	hide()
	worldMapManager.connect("toggle_save_load_opened", _on_world_manager_toggle_save_load_opened)
	
func regrab_focus():
	save_slots_list.select(0)
	save_slots_list.grab_focus()

func _on_world_manager_toggle_save_load_opened(is_opened: bool):
	if (is_opened):
		show()
		self.regrab_focus()
	else:
		hide()
		closed.emit()
		

func save_or_load_dialog():
	open_save_load_select.emit(self)

func _on_save_slots_list_item_activated(index):
	self.save_or_load_dialog()

func save_or_load_slot(saving: bool):
	var slot = save_slots_list.get_selected_items()[0]
	if saving:
		save.emit(slot + 1)
	else:
		load.emit(slot + 1)

func _on_load_or_save_box_load():
	self.save_or_load_slot(false)


func _on_load_or_save_box_save():
	self.save_or_load_slot(true)


func _on_load_or_save_box_selection_canceled():
	self.regrab_focus()
