extends Node

@export var animated_sprite: AnimatedSprite2D
@export var alc: Alc

func _on_walk_state_entered() -> void:
	animated_sprite.play('walk')
func _on_walk_state_processing(delta: float) -> void:
	if alc.velocity.x < 0:
		animated_sprite.scale.x = -1
	elif alc.velocity.x > 0:
		animated_sprite.scale.x = 1


func _on_idle_state_entered() -> void:
	animated_sprite.play('idle')


@export var inventory_ui: Control
@export var inventory_ui_grid_container: GridContainer # contains buttons
func _on_showed_state_entered() -> void:
	inventory_ui.show()
	var inventory: Inventory = G.inventory
	if inventory == null:
		return
	if inventory.storage == []:
		return
	if inventory_ui_grid_container == null:
		assert(false, "inventory_ui_grid_container == null")
	var index := 0
	for item in inventory.storage:
		var button : Button = inventory_ui_grid_container.get_child(index)
		button.icon = item.texture
		button.tooltip_text = item.item_name
		index += 1

func _on_hided_state_entered() -> void:
	inventory_ui.hide()
