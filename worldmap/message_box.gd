extends PanelContainer

signal closed

@onready var label: Label = get_node("MarginContainer/message")
@export var text: String:
	get:
		return label.text
	set(value):
		label.text = value

func _ready():
	hide()

func display():
	show()
	label.grab_focus()
	
func _input(event):
	if self.visible:
		if event.is_action_pressed("ui_accept") or event.is_action_pressed("ui_cancel"):
			label.release_focus()
			hide()
			closed.emit()
