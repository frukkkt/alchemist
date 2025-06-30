extends Button

@export var alc: Alc
@export var drink_button: Button

func _pressed() -> void:
	var inventory = G.inventory
	var index = get_parent().get_children().find(self)
	if index >= inventory.storage.size():
		return
	
	var inventory_item = inventory.storage[index]

	if inventory_item is Potion:
		show_potion_use(inventory_item)

@export var throw_button: Button
func show_potion_use(potion: Potion):
	if potion.is_for_throw:
		throw_button.visible = !throw_button.visible
		if throw_button.pressed.is_connected(_throw_potion) == true:
			throw_button.pressed.disconnect(_throw_potion)
		throw_button.pressed.connect(_throw_potion.bind(potion))
	if potion.is_for_dring:
		drink_button.visible = !drink_button.visible
		if drink_button.pressed.is_connected(_dring_potion) == true:
			drink_button.pressed.disconnect(_dring_potion)
		drink_button.pressed.connect(_dring_potion.bind(potion))


func _throw_potion(potion: Potion):
	throw_button.hide()
	alc.hands.add_potion(potion)

func _dring_potion(potion: Potion):
	drink_button.hide()
	alc.hands.add_potion(potion)

