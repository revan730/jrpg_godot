extends Node2D

func _ready():
	var t = Timer.new()
	t.set_wait_time(5.0)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	await t.timeout
	t.queue_free()
	get_tree().quit()
