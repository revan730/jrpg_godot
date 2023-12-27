extends PanelContainer

signal save
signal load
signal selection_canceled

func _input(event):
	if self.visible:
		if event.is_action_pressed("ui_cancel"):
			hide()
			selection_canceled.emit()
		if (event.is_action_pressed("right")):
			$MarginContainer/HBoxContainer.find_prev_valid_focus().grab_focus()
		if (event.is_action_pressed("left")):
			$MarginContainer/HBoxContainer.find_next_valid_focus().grab_focus()
			

func _on_load_btn_pressed():
	load.emit()
	hide()


func _on_save_btn_pressed():
	save.emit()
	hide()


func _on_load_save_menu_container_open_save_load_select(caller):
	show()
	$MarginContainer/HBoxContainer.find_next_valid_focus().grab_focus()
