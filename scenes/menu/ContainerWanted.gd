extends VBoxContainer

func set_texture(texture):
	$ContainerTexture/Texture.texture = texture
func set_reward(reward):
	$Text/Reward.text="%s" % reward	
