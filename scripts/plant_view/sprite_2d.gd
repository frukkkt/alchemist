@tool
extends Sprite2D

@export var plant_view: PlantView

func _ready() -> void:
	if plant_view != null:
		if plant_view.plant != null:
			texture = plant_view.plant.texture