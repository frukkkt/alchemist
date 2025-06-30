class_name MyArea2D
extends Area2D

signal enemy_entered(enemy)
signal enemy_exited(enemy)
signal player_entered(player)
signal player_exited(player)

var is_player_entered: bool = false
var is_enemy_entered: bool = false

@export var col_shape: CollisionShape2D

func set_radius(radius: float):
	var shape: CircleShape2D = col_shape.shape
	shape.radius = radius



func _on_body_entered(body:Node2D) -> void:
	if body is Alc:
		is_player_entered = true
		player_entered.emit(body)
	elif body is Enemy:
		is_player_entered = false
		enemy_entered.emit(body)


func _on_body_exited(body:Node2D) -> void:
	if body is Alc:
		is_enemy_entered = true
		player_exited.emit(body)
	elif body is Enemy:
		is_enemy_entered = false
		enemy_exited.emit(body)
