extends Panel

export var max_pixel=600;
export var max_value=600;
export var counter = 0;
signal container_full;
var dict_counter ={};
var dict_child = {};
var container = preload("res://scenes/interface/ContainerRect.tscn")
func _ready():
	pass
#func _process(delta):
#	pass

func addFish(fish):
	var h = int((fish.size*max_pixel)/max_value)
	if(counter+h>max_value):
		#CONTROLLO SE L'AGGIUNTA COMPORTA AL RIEMPIMENTO
		print("pieno")
		emit_signal("container_full")
	else:
		#CREO LA COLOR RECT e LA AGGIUNGO ALLA BARRA
		var rect = container.instance()
		#rect.rect_size = Vector2(36,h)
		#rect.rect_position = Vector2(2,max_pixel-2-counter-h)
		counter+=h
		rect.get_node("Border/Fish").texture = fish.get_texture()
		if(dict_counter.has(fish.get_texture())):
			dict_counter[fish.get_texture()] += 1
		else:
			dict_counter[fish.get_texture()] = 1
		rect.get_node("Label").text = "%s" % dict_counter[fish.get_texture()]
		$VScrollBar/VBoxContainer.add_child(rect)
		if(dict_child.has(fish.get_texture())):
			$VScrollBar/VBoxContainer.remove_child(dict_child[fish.get_texture()])
		dict_child[fish.get_texture()] = rect
		$Label.text =  "%s/%s" % [counter,self.max_value]
