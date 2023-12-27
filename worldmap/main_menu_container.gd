extends PanelContainer

@export var worldMapManager: WorldMapManager


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	worldMapManager.connect("toggle_game_paused", _on_world_manager_toggle_game_paused)


func _on_world_manager_toggle_game_paused(is_paused: bool):
	if (is_paused):
		show()
		$MarginContainer/VBoxContainer.find_next_valid_focus().grab_focus()
	else:
		hide()


func _on_resume_btn_pressed():
	worldMapManager.game_paused = false

func _on_save_load_btn_pressed():
	worldMapManager.open_save_load_menu()

func _on_quit_btn_pressed():
	get_tree().quit()
