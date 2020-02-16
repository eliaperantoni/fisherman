extends NinePatchRect

var lifeBar
var oxygenBar
var lifeLabel
var oxygenLabel

func _ready():
	lifeBar = $LifeBar/TextureProgress
	lifeLabel = $LifeBar/Label
	oxygenBar = $OxygenBar/TextureProgress
	oxygenLabel  = $OxygenBar/Label
	_set_oxygen(29)
	
	
func _set_oxygen(value):
	oxygenBar.value = value
	oxygenLabel.text = "O2 %s/100" % value

func _set_life(value):
	lifeBar.value = value
	lifeLabel.text = "HB %s/100" % value

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
