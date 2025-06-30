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
func _on_showed_state_entered(without_showing_ui: bool = false) -> void:
	if alc.is_bunny:
		inventory_ui.hide()
		return
	if without_showing_ui == false:
		inventory_ui.show()

	for i in inventory_ui_grid_container.get_children():
		var button : Button = i
		button.icon = null
		var label: Label = button.get_child(0)
		label.text = ''
	
	var inventory: Inventory = G.inventory
	if inventory.inventory_changed.is_connected(_on_showed_state_entered) == false:
		inventory.inventory_changed.connect(_on_showed_state_entered.bind(true))
	if inventory == null:
		return
	if inventory.storage == []:
		return
	if inventory_ui_grid_container == null:
		assert(false, "inventory_ui_grid_container == null")
	
	# delete tooltip
	for b in inventory_ui_grid_container.get_children():
		var button : Button = b
		button.tooltip_text = ''

	var index := 0
	for item in inventory.storage:
		var button : Button = inventory_ui_grid_container.get_child(index)
		var label: Label = button.get_child(0)
		button.icon = item.texture
		button.tooltip_text = item.item_name
		label.text = str(item.count)
		index += 1

func _on_hided_state_entered() -> void:
	inventory_ui.hide()

@export var wit_progress_bar: ProgressBar
func _on_lose_wit_time_state_entered() -> void:
	alc.wit.current_value -= 1.5
	if alc.wit.current_value > alc.wit.max_value:
		alc.wit.current_value -= 1.5
	wit_progress_bar.max_value = alc.wit.max_value
	wit_progress_bar.value = alc.wit.current_value

	wit_progress_bar.tooltip_text = str(alc.wit.current_value)


@export var lose_ui: Control
@export var bunny_sprite_frames: SpriteFrames
func _on_dead_by_wil_lose_state_entered() -> void:
	lose_ui.show()
	alc.animated_sprite.sprite_frames = bunny_sprite_frames
	alc.is_bunny = true


func _on_normal_state_entered() -> void:  # wit state chart
	wit_progress_bar.max_value = alc.wit.max_value
	wit_progress_bar.value = alc.wit.current_value

	wit_progress_bar.tooltip_text = str(alc.wit.current_value)

func _on_collect_plant_state_entered():
	animated_sprite.play('collect_plant')