class_name Enemy
extends CharacterBody2D

signal damage_taken
signal knocked_out

@export var speed: float = 90

var current_hp: int = 100
@export var max_hp = 100.0

func _ready() -> void:
	current_hp = max_hp

func take_damage(dmg: int):
	current_hp -= dmg
	damage_taken.emit()
	if current_hp <= 0:
		knocked_out.emit()