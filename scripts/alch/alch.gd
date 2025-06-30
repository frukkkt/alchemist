class_name Alc
extends CharacterBody2D
@export var speed = 400

signal key_inputed
signal no_key_inputed

var is_bunny: bool = false

@export var state_chart: StateChart
@export var animated_sprite: AnimatedSprite2D
@export var hands: AlcHands
@export var camera: Camera2D
var wit := Wit.new()

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	if velocity != Vector2.ZERO:
		emit_signal("key_inputed")
	elif velocity == Vector2.ZERO:
		no_key_inputed.emit()

func _physics_process(delta):
	get_input()
	move_and_slide()
