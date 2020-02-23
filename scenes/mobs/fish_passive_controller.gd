extends RigidBody2D

class_name PassiveFish

onready var sprite = $Sprite
onready var change_trip_ticker = $ChangeTripTicker

var direction: Vector2

export var min_impulse_multiplier = 50
export var max_impulse_multiplier = 100
var impulse_multiplier: float

export var min_change_trip = 1
export var max_change_trip = 5
const drag_coefficient = 0.1
export var size = 10

func _ready():
	impulse_multiplier = rand_range(min_impulse_multiplier, max_impulse_multiplier)
	
	change_trip_ticker.connect("timeout", self, "_update_trip")
	_update_trip()

func _physics_process(delta):
	self.linear_velocity *= (1 - drag_coefficient)
	
	if position.y <= 25:
		change_trip_ticker.stop()
		_update_trip(true)
	
	apply_central_impulse(direction * impulse_multiplier * delta)
	
func _update_trip(force_downward = false):
	var max_radius
	if force_downward:
		max_radius = PI
	else:
		max_radius = 2 * PI
	
	direction = Vector2(1,0)
	direction = direction.rotated(rand_range(0, max_radius))
	direction = direction.normalized()
	
	sprite.scale.x = -1 if direction.x < 0 else 1
	
	var wait_time = rand_range(min_change_trip, max_change_trip)
	change_trip_ticker.start(wait_time)
func get_texture():
	return $Sprite.texture
