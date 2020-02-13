extends Node2D

export var dragCoefficien = 0.1
export var impulseMultiplier = 4000

var body: RigidBody2D

func _ready():
	body = $RigidBody

func _physics_process(delta):
	body.linear_velocity *= (1 - dragCoefficien)

	var direction = Vector2(0, 0)

	if Input.is_key_pressed(KEY_D):
		direction += Vector2(1, 0)
	if Input.is_key_pressed(KEY_S):
		direction += Vector2(0, 1)
	if Input.is_key_pressed(KEY_A):
		direction += Vector2(-1, 0)
	if Input.is_key_pressed(KEY_W):
		direction += Vector2(0, -1)

	body.apply_central_impulse(direction * impulseMultiplier * delta)
