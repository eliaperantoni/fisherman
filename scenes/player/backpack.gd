extends Node2D

class_name Backpack

export var max_value=600
var fill = 0 # Indentifica quanto l'inventario è pieno

var content = []

signal fish_added(fish, fill)

func add_fish(fish):
	if(fill+fish.size>max_value):
		# Inventario pieno
		return false
	# Inventario non pieno
	fill+=fish.size
	content.append(fish)
	emit_signal("fish_added", fish, fill)
	return true

func add_fishes(fishes):
	for fish in fishes:
		if(not add_fish(fish)):
			return false
	return true
