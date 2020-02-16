extends NinePatchRect

func _ready():
	_set_oxygen(100)
	_set_life(100)
	_set_deep(0)

	
func _set_oxygen(value):
	$OxygenBar/TextureProgress.value = value
	$OxygenBar/Label.text = "O2 %s/100" % value

func _set_life(value):
	$LifeBar/TextureProgress.value = value
	$LifeBar/Label.text = "HB %s/100" % value

func _set_deep(value):
	$DeepCounter.text = "DEEP - %s " % value	
