extends Node

@export var portal_base: PortalBase

var portal_created: bool = false

@export var area: Area2D
func _on_try_create_portal_state_entered() -> void:
	if G.get_player().is_bunny:
		return
	if portal_created:
		return
	var ingredients_for_create_portal = portal_base.ingredients_for_create_portal
	if G.inventory.has_items(ingredients_for_create_portal):
		G.inventory.delete_items(ingredients_for_create_portal)
	portal_created = true
	portal_base.portal_for_create.show()
	portal_base.portal_for_create.disabled = false
	area.hide()
		

@export var portal_base_ui: Control
@export var ingredients_container: HBoxContainer # contains TextureRect, он хранит label
func _on_show_ui_state_entered() -> void:
	if G.get_player().is_bunny:
		return
	if portal_created:
		return
	portal_base_ui.show()
	
	ingredients_container.get_children().map(func(x): x.hide())

	var index := 0
	for i in portal_base.ingredients_for_create_portal:
		var texture_rect: TextureRect = ingredients_container.get_children()[index]
		texture_rect.show()
		var count_label: Label = texture_rect.get_child(0)
		texture_rect.texture = i.texture
		count_label.text = str(i.count)
		index += 1



func _on_show_ui_state_exited() -> void:
	portal_base_ui.hide()
