extends TextureRect
var fishes_test = {
	0:preload("res://scenes/mobs/FishOblungo.tscn").instance(),
	1:preload("res://scenes/mobs/Fish1.tscn").instance(),
	2:preload("res://scenes/mobs/Fish2.tscn").instance(),
	3:preload("res://scenes/mobs/Fish3.tscn").instance(),
	4:preload("res://scenes/mobs/Fish4.tscn").instance(),
	5:preload("res://scenes/mobs/FishCarango.tscn").instance(),
	6:preload("res://scenes/mobs/FishCarangoCrystal.tscn").instance()
}

func _ready():
	var test_wanted = {
		fishes_test[0]:10,
		fishes_test[1]:30,
		fishes_test[2]:20,
		fishes_test[3]:40,
		fishes_test[4]:10,
		fishes_test[5]:230,
		fishes_test[6]:1300,
		}
	add_fishes_wanted(test_wanted)

func add_fishes_wanted(fishes):
	#fishes è un dizionario avente come chiave un pesce e valore la sua relativa taglia
	for fish in fishes:
		#fishes[fish]=reward
		$MarginLeft/LeftMenu/MarginContainer/ContainerOptions.add_wanted(fish,fishes[fish])
