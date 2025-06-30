extends Node

@export var cauldron_ui: Control
@export var alc: Alc

func _on_ui_opened_state_entered() -> void:
	if alc.is_bunny:
		return
	cauldron_ui.show()



func _on_normal_state_entered() -> void:
	cauldron_ui.hide()
