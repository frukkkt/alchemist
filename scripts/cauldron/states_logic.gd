extends Node

@export var cauldron_ui: Control

func _on_ui_opened_state_entered() -> void:
	cauldron_ui.show()



func _on_normal_state_entered() -> void:
	cauldron_ui.hide()

