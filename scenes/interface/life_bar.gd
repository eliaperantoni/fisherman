extends Bar

func on_life_changed(old_life, new_life):
	self.value = int(new_life)
