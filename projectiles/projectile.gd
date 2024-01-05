extends Node

class_name Projectile
@export var x_velocity = 800
@export var y_velocity = 800

signal target_hit

var target: Area2D

func _on_target_body_entered(body):
	print_debug("Collided with target")
	target_hit.emit()

func set_target(t: Area2D):
	target = t
	print_debug("Setting target")
	target.connect("body_entered", _on_target_body_entered)

func _process(delta):
	if !target:
		pass
	else:
		if self.position.x < target.global_position.x:
			self.position.x += x_velocity * delta
		elif self.position.x > target.global_position.x:
			self.position.x -= x_velocity * delta
		if self.position.y < target.global_position.y:
			self.position.y += y_velocity * delta
		elif self.position.y > target.global_position.y:
			self.position.y -= y_velocity * delta
