class_name PotionView
extends Node2D

@export var sprite: Sprite2D

var potion: Potion

func setup(_potion: Potion):
	potion = _potion
	sprite.texture = potion.texture


var throw_speed: float = 180.0

func delete_potion_from_inventory():
	G.inventory.delete_item(potion.duplicate(true))

func get_time_by_distance_and_speed():
	var distance = self.global_position.distance_to(get_global_mouse_position())
	return distance / throw_speed

@export var explosion_sprite: AnimatedSprite2D
func throw():
	delete_potion_from_inventory()
	await move_to_projectiles_parent()

	var tween := get_tree().create_tween()
	var time = get_time_by_distance_and_speed()
	tween.tween_property(self, "global_position", get_global_mouse_position(), time)
	await tween.finished
	explosion_sprite.play('explosion')
	sprite.hide()
	await explosion_sprite.animation_finished
	queue_free()

func move_to_projectiles_parent():
	var projectiles = get_tree().get_first_node_in_group('projectiles')
	get_parent().remove_child(self)
	projectiles.add_child(self)
	self.global_position = get_tree().get_first_node_in_group('player').global_position
	

@export var anim_player: AnimationPlayer
func drink():
	delete_potion_from_inventory()
	anim_player.play('drink')
	await anim_player.animation_finished
	potion.potion_effect.drink_effect()
	queue_free()
