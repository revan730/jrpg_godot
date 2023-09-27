extends CharacterBody2D

@export var move_speed = 250


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var horizontal_direction = Input.get_action_strength("right") - Input.get_action_strength("left")
	var vertical_direction = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	if horizontal_direction != 0:
		vertical_direction = 0
	
	var direction = Vector2(horizontal_direction, vertical_direction).normalized()
	match direction:
		Vector2.LEFT:
			$sprite.animation = "left"
		Vector2.RIGHT:
			$sprite.animation = "right"
		Vector2.UP:
			$sprite.animation = "up"
		Vector2.DOWN:
			$sprite.animation = "down"
		Vector2.ZERO:
			$sprite.animation = "idle"
	velocity = direction * move_speed
	move_and_slide()
	
