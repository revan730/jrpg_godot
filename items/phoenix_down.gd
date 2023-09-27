extends Usable

class_name PhoenixDown

func _init():
	self.item_name = "Phoenix Down"
	self.cost = 300
	self.info = "Resurrects party member"

func apply_effect(target):
	target.ressurect()
	
func check_applicable(target):
	return target.hp == 0
