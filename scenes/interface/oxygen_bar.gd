extends Bar

func on_oxygen_changed(oxygen_level):
	self.value = int(oxygen_level)
