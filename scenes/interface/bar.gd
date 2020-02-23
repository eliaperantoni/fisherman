extends HBoxContainer

onready var bar = $Bar
onready var label = $Value

var value = 0 setget set_value

func set_value(new_value):
	value = new_value
	bar.value = value
	label.text = str(value)
