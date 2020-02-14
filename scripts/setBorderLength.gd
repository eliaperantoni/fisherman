extends Node

export var length = 32

func _ready():
	var sprite: Sprite = $Sprite
	sprite.region_rect = Rect2(0, 0, 32, length)
