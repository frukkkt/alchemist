class_name PortalBase
extends Node2D


@export var ingredients_for_create_portal: Array[InventoryItem]

@export var portal_for_create: Portal

func _ready() -> void:
	portal_for_create.hide()