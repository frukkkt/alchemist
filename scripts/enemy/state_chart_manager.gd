extends Node

@export var state_chart: StateChart
@export var enemy: Enemy

func _on_attack_zone_body_entered(body: Node2D):
	if body.is_in_group('player'):
		state_chart.send_event('player_entered_to_zone')


func _on_attack_zone_body_exited(body:Node2D) -> void:
	if body.is_in_group('player'):
		state_chart.send_event('player_exited_from_zone')


func _on_enemy_damage_taken() -> void:
	state_chart.set_expression_property("enemy_current_hp", enemy.current_hp)
	state_chart.send_event("enemy_damaged")
