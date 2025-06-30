class_name AlcHands
extends Node2D

@export var dring_potion_pos: Marker2D

var current_potion_view: PotionView

func add_potion(potion: Potion):
	create_potion_view(potion)

var packed_potion_view: PackedScene = load('uid://dimsp3ppyjs6j')
func create_potion_view(potion: Potion) -> bool:
	var new_potion_view: PotionView = packed_potion_view.instantiate()
	if current_potion_view != null:
		return false
	add_child(new_potion_view)
	new_potion_view.setup(potion)
	current_potion_view = new_potion_view
	if potion.is_for_throw:
		show_info_under_cursor()
		setup_throw_sprite_radius()
	if potion.is_for_dring:
		current_potion_view.drink()
		current_potion_view.global_position = dring_potion_pos.global_position
	return true

@export var info_under_cursor: Control
func show_info_under_cursor():
	info_under_cursor.show()

@export var throw_potion_sprite_radius: Sprite2D
func setup_throw_sprite_radius():
	var gradient: GradientTexture2D =  throw_potion_sprite_radius.texture
	gradient.width = int(current_potion_view.potion.potion_throw_diagonal)
	gradient.height = int(current_potion_view.potion.potion_throw_diagonal)
	throw_potion_sprite_radius.show()

func _input(event: InputEvent) -> void:
	if current_potion_view == null:
		return
	if current_potion_view.potion.is_for_throw:
		if event.is_action_pressed("left_click"):
			if info_under_cursor.visible == true:
				var distance_from_player_to_mouse =G.get_player().global_position.distance_to(get_global_mouse_position())
				print(distance_from_player_to_mouse )
				print(current_potion_view.potion.potion_throw_radius)
				if distance_from_player_to_mouse <= current_potion_view.potion.potion_throw_radius:
					current_potion_view.throw()
					info_under_cursor.hide()
					current_potion_view = null
					throw_potion_sprite_radius.hide()
		elif event.is_action_pressed("right_click"):
			if info_under_cursor.visible == true:
				info_under_cursor.hide()
				current_potion_view.queue_free()
				current_potion_view = null
				throw_potion_sprite_radius.hide()

func _process(delta: float) -> void:
	info_under_cursor.position = get_viewport().get_mouse_position()
	info_under_cursor.position.x -= info_under_cursor.size.x / 2
	info_under_cursor.position.y += 30
