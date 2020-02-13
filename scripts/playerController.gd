extends Node2D

export var dragCoefficien = 0.1
export var impulseMultiplier = 3000

var body: RigidBody2D

func _ready():
	body = $RigidBody

func _physics_process(delta):
	body.linear_velocity *= (1 - dragCoefficien)
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
	body.apply_central_impulse(direction * impulseMultiplier * delta)
	get_parent().get_node("Camera").position = body.position
