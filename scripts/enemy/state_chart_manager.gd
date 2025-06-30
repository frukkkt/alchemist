extends Node

@export var state_chart: StateChart

func _on_attack_zone_body_entered(body: Node2D):
	if body.is_in_group('player'):
		state_chart.send_event('player_entered_to_zone')


func _on_attack_zone_body_exited(body:Node2D) -> void:
	if body.is_in_group('player'):
		state_chart.send_event('player_exited_from_zone')
