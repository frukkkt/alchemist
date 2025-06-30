class_name Potion
extends InventoryItem

@export var is_for_throw: bool = false
@export var potion_throw_diagonal: float = 100.0
var potion_throw_radius: float = 0.0: get = get_potion_throw_radius
@export var is_for_dring: bool = false

@export var potion_effect: PotionEffect



func get_potion_throw_radius():
	return potion_throw_diagonal / 2.0