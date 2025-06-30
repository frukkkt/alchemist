extends ProgressBar

@export var label: Label
@export var label2: Label

func _on_value_changed(value:float) -> void:
	label.text = str(int(value))
	label2.text = str(int(value))
	label2.show()
	var tween = get_tree().create_tween()
	var post_pos = label2.position
	tween.tween_property(label2, 'position', label2.position + Vector2(15, 0), 0.3)
	await tween.finished
	label2.position = post_pos
	label2.hide()

func _ready() -> void:
	_on_value_changed(value)
