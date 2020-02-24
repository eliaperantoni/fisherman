extends Panel

export var max_value=600;
export var fill = 0; #Indentifica quanto l'inventario è pieno
var container_fish = preload("res://scenes/interface/fish_bar/ContainerFish.tscn")
var dict_counter ={};	#CONTATORE DI SPECIE CATTURATE
var dict_child = {};	#REFERENZA OGGETTO CONTAINER PER OGNI SPECIE
signal container_full;

func addFish(fish):
	if(fill+fish.size>max_value):
		#INVENTARIO PIENO
		emit_signal("container_full")
		return false;
	#INVENTARIO NON PIENO	
	fill+=fish.size
	if(dict_counter.has(fish.get_texture())):
		#CONTROLLO SE E' GIA' PRESENTE E IN CASO AGGIORNO LA TEXTURE E IL CONTATORE
		dict_counter[fish.get_texture()] += 1
		dict_child[fish.get_texture()].get_node("Label").text = "%s" % dict_counter[fish.get_texture()]
	else:
		#CREO L'OGGETTO CONTAINER SE NON E' PRESENTE
		var rect = container_fish.instance()
		rect.get_node("Border/Fish").texture = fish.get_texture()
		dict_counter[fish.get_texture()] = 1
		dict_child[fish.get_texture()] = rect
		$VScrollBar/VBoxContainer.add_child(rect)
	$Label.text =  "%s/%s" % [fill,self.max_value]
	return true;

func addFishes(fishes):
	for fish in fishes:
		if(not addFish(fish)):
			return false
	return true
