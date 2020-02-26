extends RigidBody2D

export var drag_coefficient = 0.1
export var impulse_multiplier = 30000
export var oxygen = 100
export var life = 100
export var oxygen_refill = 10
export var oxygen_decrease = 4

var on_surface = true #initially player is on surface

#Used for giggle effect
var goUpDown = true #true when going from -1 to 1, false otherwise
var time = 0 #Oscillates in range [-1,1]

var was_going_up = false;
var set_to_surface = true; #True after setting player to surface heigth

var is_moving = false #Initally player is on surface, standing still, just wiggly
var is_descending = false
var is_ascending = false;

var impulse = Vector2(0, 0);
var direction = Vector2(0, 0)
signal player_moved
signal oxygen_modified
signal life_modified
signal oxygen_end
signal life_end

func _physics_process(delta):
	
	self.linear_velocity *= (1 - drag_coefficient) #pera sa ela sta roba

	#Reset vars
	is_moving = false
	impulse = Vector2(0,0)
	is_descending = false
	is_ascending = false
	direction = Vector2(0,0)
	
	load_user_input()
	
	if(direction.x != 0 or direction.y != 0): is_moving = true
		
	#Apply wiggly effect----------------------
	#update_time_for_giggle()
	#position += Vector2(cos(time) * 0.02, sin(time) * 0.03) * 75
	
	#Compute and apply impulse---------------
	print(on_surface, " - ", set_to_surface, " - ", is_moving, " - ", is_ascending)
	
	if is_moving:
		impulse = direction * delta * impulse_multiplier * (4 if Input.is_key_pressed(KEY_SHIFT) else 1)

	#Player cant go up if on surface
	if on_surface and is_ascending: impulse.y = 0
	
	if(abs(6-position.y) > 0.5): set_to_surface = false
	
	if ((on_surface and not set_to_surface) and (not is_moving or is_ascending)):
		#Return to sea level		
		if abs((6-position.y)/3) >= 0.05:
			impulse.y = ((6-position.y)/3)*delta * 5000
		else:
			impulse.y = ((6-position.y))*delta * 5000
			set_to_surface = true;
						
	#else:
		#Just wiggle in place
			
	self.apply_central_impulse(impulse)	
	
	
	#Update Oxygen value---------------
	if on_surface:
		oxygen += delta * oxygen_refill
		_oxygen_modified(oxygen)
	else:
		oxygen -= delta * oxygen_decrease
		_oxygen_modified(oxygen)

func load_user_input():
	#W / up
	if Input.is_action_pressed("ui_up"):
		is_ascending = true
		direction += Vector2(0, -1)
	#A / left
	if Input.is_action_pressed("ui_left"):
		direction += Vector2(-1, 0)
	#S / down
	if Input.is_action_pressed("ui_down"):
		is_descending = true
		direction += Vector2(0, 1)
	#D / right
	if Input.is_action_pressed("ui_right"):
		direction += Vector2(1, 0)
	
	direction = direction.normalized()
	
func update_time_for_giggle():
	if goUpDown:
		time += 0.025
	else:
		time -= 0.025
	
	#Update goUpDown
	if(time == 1):
		goUpDown = false #Now go down to -1
	if(time == -1):
		goUpDown = true #Now go up to 1

func _oxygen_modified(value):
	#Il valore inserito è già in percentuale
	if value > 100:
		value = 100
	if value < 0:
		value = 0
		emit_signal("oxygen_end")
	oxygen = value
	emit_signal("oxygen_modified", int(oxygen))
	
func _on_water_entered(body):
	if body == self:
		on_surface = false
		set_to_surface = false
		self.gravity_scale = 0

func _on_water_exited(body):
	if body == self:
		on_surface = true
		#self.gravity_scale = 5

func _life_decrease(poit_decrease):
	life -= poit_decrease
	if (life <= 0):
		life = 0
		emit_signal("life_end")
	emit_signal("life_modified",life)
