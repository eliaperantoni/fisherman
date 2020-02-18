extends RigidBody2D

export var dragCoefficient = 0.1
export var impulseMultiplier = 50000
export var oxygen = 100
export var oxygenDuration = 20
export var life = 100
var canSwim = true
signal playerMoved
signal oxygenModified
func _ready():
	$OxygenTimer.set_wait_time(oxygenDuration);
	
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
	if not canSwim:
		direction.y = 0
	self.apply_central_impulse(direction * delta * impulseMultiplier * (10 if Input.is_key_pressed(KEY_SHIFT) else 1))
	if direction != Vector2(0,0) or not canSwim:
		emit_signal("playerMoved", position)
	if(not $OxygenTimer.is_stopped()):
		_oxygenModified(($OxygenTimer.time_left * 100)/oxygenDuration);

func _oxygenModified(value):
	#Il valore inserito è già in percentuale
	oxygen = int(value)
	emit_signal("oxygenModified",oxygen)
func _on_water_entered(body):
	if body == self:
		canSwim = true
		self.gravity_scale = 0
		var start = (oxygenDuration * oxygen)/100;
		$OxygenTimer.set_wait_time(start);
		$OxygenTimer.start();

func _on_water_exited(body):
	if body == self:
		canSwim = false
		self.gravity_scale = 9.8
		$OxygenTimer.stop();

func _on_OxygenTimer_timeout():
	$OxygenTimer.stop()
	print("sei morto")
