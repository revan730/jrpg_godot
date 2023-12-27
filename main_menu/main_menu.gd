extends Node2D

func _ready():
	$menu_ui/menu_panel/VBoxContainer.find_next_valid_focus().grab_focus()

func _on_new_game_btn_pressed():
	get_tree().change_scene_to_file("res://overworld/overworld.tscn")

func _on_load_game_btn_pressed():
	get_tree().change_scene_to_file("res://main_menu/load_game.tscn")

func _on_exit_btn_pressed():
	get_tree().quit()
