extends RigidBody2D

export var drag_coefficient = 0.1
export var impulse_multiplier = 50000
export var oxygen = 100
export var life = 100
export var oxygen_refill = 10
export var oxygen_decrease = 4

var can_swim = true

signal player_moved
signal oxygen_modified
signal life_modified
signal oxygen_end
signal life_end

func _physics_process(delta):
	self.linear_velocity *= (1 - drag_coefficient)

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
	
	if not can_swim:
		direction.y = 0
		
	self.apply_central_impulse(direction * delta * impulse_multiplier * (10 if Input.is_key_pressed(KEY_SHIFT) else 1))	
	if can_swim:
		oxygen -= delta*oxygen_decrease;
		_oxygen_modified(oxygen)
	else:
		oxygen += delta*oxygen_refill
		_oxygen_modified(oxygen)

func _oxygen_modified(value):
	#Il valore inserito è già in percentuale
	if value>100:
		value=100
	if value<0:
		value=0
		emit_signal("oxygen_end")
	oxygen = value
	emit_signal("oxygen_modified", int(oxygen))
	
func _on_water_entered(body):
	if body == self:
		can_swim = true
		self.gravity_scale = 0

func _on_water_exited(body):
	if body == self:
		can_swim = false
		self.gravity_scale = 10


func _life_decrease(poit_decrease):
	life -=poit_decrease
	if(life<=0):
		life = 0
		emit_signal("life_end")
	emit_signal("life_modified",life)
