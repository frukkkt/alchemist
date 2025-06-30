extends Node

@export var animated_sprite: AnimatedSprite2D
@export var enemy: Enemy

func _on_run_state_entered():
	animated_sprite.play('run')
	move_to_player()

func move_to_player():
	player_target = G.get_player()
	go_move_to_player = true

var player_target: Alc
var go_move_to_player: bool
func _physics_process(delta: float) -> void:
	if go_move_to_player:
		if player_target != null:
			var direction = player_target.global_position - enemy.global_position
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


@export var enemy_collision_shape: CollisionShape2D
func _on_knocked_out_state_entered() -> void:
	animated_sprite.play('knocked_out')
	enemy_collision_shape.set_disabled.call_deferred(true) # чтобы можно было ходить по трупу

var is_awaiting_execution: bool = false
@export var execution_prompt_label: Label
func _on_awaiting_execution_state_entered() -> void:
	is_awaiting_execution = true
	execution_zone.player_entered.connect(show_execution_prompt_label)
	execution_zone.player_exited.connect(hide_execution_prompt_label)

func hide_execution_prompt_label(_player):
	execution_prompt_label.hide()

func show_execution_prompt_label(_player):
	execution_prompt_label.show()

@export var execution_zone: MyArea2D
func _input(event: InputEvent) -> void:
	if event.is_action_pressed('space') and execution_zone.is_player_entered:
		var _player: Alc = G.get_player()
		_player.animated_sprite.play('execution')
		if _player.animated_sprite.animation_finished.is_connected(drop_loot):
			_player.animated_sprite.animation_finished.disconnect(drop_loot)
		_player.animated_sprite.animation_finished.connect(drop_loot.bind(_player.animated_sprite))

func drop_loot(player_anim_sprite: AnimatedSprite2D):
	if player_anim_sprite.animation == "execution":
		print_debug("TODO: DROP LOOT")
		enemy.queue_free()
