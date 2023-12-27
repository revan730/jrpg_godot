extends Node2D

@onready var saveLoadManager = get_node("/root/SaveLoadManager")

func _ready():
	$load_ui/menu_panel/VBoxContainer.find_next_valid_focus().grab_focus()

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://main_menu/main_menu.tscn")

func _on_load_slot_1_btn_pressed():
	saveLoadManager.load_game(1)

func _on_load_slot_2_btn_pressed():
	saveLoadManager.load_game(2)

func _on_load_slot_3_btn_pressed():
	saveLoadManager.load_game(3)

func _on_load_slot_4_btn_pressed():
	saveLoadManager.load_game(4)

func _on_load_slot_5_btn_pressed():
	saveLoadManager.load_game(5)

func _on_load_slot_6_btn_pressed():
	saveLoadManager.load_game(6)
