extends PotionEffect

@export var explosion_damage := 100
@export var explosion_radius := 100.0

func throw_effect(args: Array = []):
	var area_position: Vector2 = args[0]

	var main: MainScene = G.get_main_scene()
	
	var packed_my_area: PackedScene = load("uid://dees2k3s71ghi")
	var my_area: MyArea2D = packed_my_area.instantiate()
	my_area.set_radius(explosion_radius)

	my_area.enemy_entered.connect(_on_enemy_entered.bind(my_area))
	main.add_child(my_area)
	my_area.global_position = area_position

func _on_enemy_entered(enemy: Enemy, my_area):
	enemy.take_damage(explosion_damage)
	my_area.queue_free()