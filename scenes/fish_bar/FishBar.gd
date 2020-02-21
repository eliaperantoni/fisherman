extends HBoxContainer

export var max_value=600;
export var max_pixel=600;
export var counter = 0;
signal container_full;
func _ready():
	pass
	#addFish(10,60,Color( 0.5, 1, 0.83, 1 ))

#func _process(delta):
#	pass

func addFish(fish):
	var h = int((fish.size*max_pixel)/max_value)
	if(counter+h>max_pixel):
		#CONTROLLO SE L'AGGIUNTA COMPORTA AL RIEMPIMENTO
		print("pieno")
		emit_signal("container_full")
	else:
		#CREO LA COLOR RECT e LA AGGIUNGO ALLA BARRA
		var rect = ColorRect.new()
		rect.rect_size = Vector2(36,h)
		rect.rect_position = Vector2(2,max_pixel-2-counter-h)
		counter+=h
		rect.color=fish.color
		$FishContainer.add_child(rect)
		$Label.text =  "%s/100" % counter
