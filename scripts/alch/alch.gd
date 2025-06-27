class_name Alc
extends CharacterBody2D
@export var speed = 400

signal key_inputed
signal no_key_inputed

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
