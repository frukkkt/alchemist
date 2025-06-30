extends Node

func get_plant() -> InventoryItem:
	return plant_view.plant

var plant: InventoryItem : get = get_plant
@export var plant_view: PlantView

func _on_collection_state_entered() -> void:
	var alc := G.get_player()
	if alc.is_bunny:
		return
	alc.state_chart.send_event("collect_plant")
	if alc.animated_sprite.animation_finished.is_connected(collect) == true:
		alc.animated_sprite.animation_finished.disconnect(collect)
	alc.animated_sprite.animation_finished.connect(collect)
	
func _on_collection_state_exited() -> void:
	var alc := G.get_player()
	if alc.animated_sprite.animation_finished.is_connected(collect) == true:
		alc.animated_sprite.animation_finished.disconnect(collect)


func collect():
	if G.get_player().animated_sprite.animation == 'collect_plant':
		if plant == null:
			return
		G.inventory.add_item(plant.duplicate(true)) # bug fixed #1
		plant_view.queue_free()
		plant = null


@export var space_label: Label
func _on_text_state_entered() -> void:
	if G.get_player().is_bunny:
		return
	space_label.show()


func _on_text_state_exited() -> void:
	space_label.hide()
	

@export var sprite2d: Sprite2D
func _on_normal_state_entered() -> void:
	sprite2d.texture = get_plant().texture
	space_label.hide()
