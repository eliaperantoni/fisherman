extends Panel

var container_fish = preload("res://scenes/interface/fish_bar/ContainerFish.tscn")
# CONTATORE DI SPECIE CATTURATE
var dict_counter ={}
# REFERENZA OGGETTO CONTAINER PER OGNI SPECIE
var dict_child = {}

var max_value

func on_fish_added(fish, fill):
	if(dict_counter.has(fish.get_texture())):
		# CONTROLLO SE E' GIA' PRESENTE E IN CASO AGGIORNO LA TEXTURE E IL CONTATORE
		dict_counter[fish.get_texture()] += 1
		dict_child[fish.get_texture()].get_node("Label").text = "%s" % dict_counter[fish.get_texture()]
	else:
		# CREO L'OGGETTO CONTAINER SE NON E' PRESENTE
		var rect = container_fish.instance()
		rect.get_node("Label").text = "1"
		rect.get_node("Border/Fish").texture = fish.get_texture()
		dict_counter[fish.get_texture()] = 1
		dict_child[fish.get_texture()] = rect
		$VScrollBar/VBoxContainer.add_child(rect)
	$Label.text =  "%s/%s" % [fill, max_value]
