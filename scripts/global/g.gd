extends Node

var inventory: Inventory

func _ready() -> void:
	inventory = Inventory.new()
	var inventory_item := InventoryItem.new()
	inventory_item.texture = load("uid://lak6spi51y81")
	inventory_item.item_name = 'Crimson Capsicum'
	inventory.storage.append(inventory_item)
	
	inventory.storage.append(inventory_item.duplicate())

	inventory_item = InventoryItem.new()
	inventory_item.texture = load("uid://cboyy3imi5t2l")
	inventory_item.item_name = 'Sunroot Dust'
	inventory.storage.append(inventory_item)
