extends HBoxContainer

@export var brew_button: Button
@export var ingredients: Array[InventoryItem] = []
@export var potion: Potion
@export var potion_count: int = 1

var ingredients_texture_rects: Array[TextureRect]
var potion_texture_rect: TextureRect


func _ready() -> void:
	for i in get_children():
		if i.is_in_group("ingredient_texture_rect"):
			ingredients_texture_rects.append(i)
		if i.is_in_group("potion_texture_rect"):
			potion_texture_rect = i
	
	for i in ingredients_texture_rects:
		i.hide()
	
	var index := 0
	for i in ingredients:
		var texture_rect: TextureRect = ingredients_texture_rects[index]
		var label: Label = texture_rect.get_child(0)
		texture_rect.show()
		texture_rect.texture = i.texture
		texture_rect.tooltip_text = i.item_name
		label.text = str(i.count)
		index += 1
	
	potion_texture_rect.texture = potion.texture
	potion_texture_rect.tooltip_text = potion.item_name
	var _label: Label = potion_texture_rect.get_child(0)
	_label.text = str(potion_count)
	
	
	
		

func _on_button_pressed() -> void:
	if G.inventory.delete_items(ingredients.duplicate(true)) == true:
		G.inventory.add_item(potion.duplicate(true))
