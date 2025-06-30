class_name Inventory
extends Resource

signal inventory_changed

@export var storage: Array[InventoryItem]


func has_items(items: Array[InventoryItem]):
	var is_has = []
	var _storage = storage.duplicate()
	for i in items:
		for j in storage:
			if i.item_name == j.item_name:
				if j.count >= i.count:
					is_has.append(true)
					_storage.erase(j)
					break
	if is_has.size() == items.size():
		return true
	else:
		return false

func delete_item(item: InventoryItem, one_item: bool = true):
	for i in storage:
		if i.item_name == item.item_name:
			if i.count >= item.count:
				if one_item:
					i.count -= 1
				else:
					i.count = 0
					storage.erase(i)
				inventory_changed.emit()
				if i.count == 0:
					storage.erase(i)
					inventory_changed.emit()

func delete_items(items: Array[InventoryItem]):
	if has_items(items) == false:
		return false
	for i in items:
		delete_item(i)
	return true
				

func add_item(item: InventoryItem):
	if has_items([item]) == true:
		for i in storage:
			if i.item_name == item.item_name:
				i.count += item.count
	else:
		storage.append(item)
	inventory_changed.emit()