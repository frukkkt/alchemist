extends Node

@export var portal: Portal
@export var portal_label: RichTextLabel 

func get_alc() -> Alc:
	return get_tree().get_first_node_in_group('player')

func _on_text_state_entered() -> void:
	if get_alc().is_bunny:
		return
	if portal.disabled:
		return
	portal_label.show()


func _on_text_state_exited() -> void:
	portal_label.hide()


func _on_teleporting_state_entered() -> void:
	var player: Alc = get_tree().get_first_node_in_group('player')
	if player.is_bunny:
		return
	if portal.disabled:
		return
	player.global_position = portal.linked_portal.global_position
	player.camera.position_smoothing_enabled = false
	await get_tree().create_timer(1.0).timeout
	player.camera.position_smoothing_enabled = true
