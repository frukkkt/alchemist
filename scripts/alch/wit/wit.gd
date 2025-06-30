class_name Wit
extends Resource

signal wit_changed

func set_current_value(value):
	current_value = value
	wit_changed.emit()

var current_value = 50.0: set = set_current_value
var max_value = 100.0