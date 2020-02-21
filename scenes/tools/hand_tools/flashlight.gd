extends HandToolCursor

var on = true setget on_torchlight_toggle
func on_torchlight_toggle(val):
	on = val
	$Light.enabled = on

func _input(_event):
	if Input.is_action_just_pressed("tool_action_a"):
		self.on = not on
