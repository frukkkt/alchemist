extends Node

var inventory: Inventory = load("res://scripts/inventory/start_inventory.tres")


func get_player() -> Alc:
	return get_tree().get_first_node_in_group('player')

func get_main_scene() -> MainScene:
	return get_tree().get_first_node_in_group('main_scene')