extends Node

@export var animated_sprite: AnimatedSprite2D
@export var enemy: Enemy

func _on_run_state_entered():
	animated_sprite.play('run')
	move_to_player()

func move_to_player():
	player = G.get_player()
	go_move_to_player = true

var player: Alc
var go_move_to_player: bool
func _physics_process(delta: float) -> void:
	if go_move_to_player:
		if player != null:
			var direction = player.global_position - enemy.global_position
			direction = direction.normalized()
			enemy.velocity = direction * enemy.speed
			enemy.move_and_slide()




func _on_idle_state_entered() -> void:
	animated_sprite.play('idle')
	go_move_to_player = false

func _on_hurt_state_entered():
	animated_sprite.play('hurt')
	go_move_to_player = false


func _on_run_state_processing(delta:float) -> void:
	if enemy.velocity.x < 0:
		animated_sprite.scale.x = 1
	elif enemy.velocity.x > 0:
		animated_sprite.scale.x = -1
