extends PotionEffect

@export var additional_wit: float = 22.0

func drink_effect():
	var player: Alc = G.get_tree().get_first_node_in_group('player')
	player.wit.current_value += additional_wit
	print('drink effectg')
