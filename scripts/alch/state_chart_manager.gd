extends Node

@export var alc: Alc
@export var state_chart: StateChart

func _ready() -> void:
	alc.key_inputed.connect(send_key_inputed_event_to_state_chart)

	alc.no_key_inputed.connect(send_no_key_inputed_event_to_state_chart)

func send_key_inputed_event_to_state_chart():
	state_chart.send_event("key_inputed")

func send_no_key_inputed_event_to_state_chart():
	state_chart.send_event("no_key_inputed")

var e_key_toggle := false
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("e_key"):
		e_key_toggle = !e_key_toggle
		state_chart.set_expression_property("e_key_toggle", e_key_toggle)
		state_chart.send_event("e_key_pressed")
