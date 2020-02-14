extends RigidBody2D

export var dragCoefficient = 0.1
export var impulseMultiplier = 3000

func _physics_process(delta):
	self.linear_velocity *= (1 - dragCoefficient)

	var direction = Vector2(0, 0)

	#D / right
	if Input.is_action_pressed("ui_right"):
		direction += Vector2(1, 0)
	#S / down
	if Input.is_action_pressed("ui_down"):
		direction += Vector2(0, 1)
	#A / left
	if Input.is_action_pressed("ui_left"):
		direction += Vector2(-1, 0)
	#W / up
	if Input.is_action_pressed("ui_up"):
		direction += Vector2(0, -1)

	direction = direction.normalized()

	self.apply_central_impulse(direction * impulseMultiplier * delta)
