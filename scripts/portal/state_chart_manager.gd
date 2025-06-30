extends Node

@export var state_chart: StateChart


func _on_area_2d_body_entered(body:Node2D) -> void:
	if body.is_in_group('player'):
		state_chart.send_event('player_entered')


func _on_area_2d_body_exited(body:Node2D) -> void:
	if body.is_in_group('player'):
		state_chart.send_event('player_exited')

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("t_key"):
		state_chart.send_event("t_key_pressed")
