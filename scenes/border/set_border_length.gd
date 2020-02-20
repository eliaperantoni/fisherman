extends StaticBody2D
tool

export var length = 32
onready var sprite = $Sprite

func _ready():
	sprite.region_rect = Rect2(0, 0, 32, length)
