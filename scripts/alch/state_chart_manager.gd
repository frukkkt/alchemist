extends Node

@export var alc: Alc
@export var state_chart: StateChart
@export var wit_lose_timer: Timer

func _ready() -> void:
	alc.key_inputed.connect(send_key_inputed_event_to_state_chart)

	alc.no_key_inputed.connect(send_no_key_inputed_event_to_state_chart)

	wit_lose_timer.timeout.connect(_send_5_sec_passed_to_state_chart)

	alc.wit.wit_changed.connect(_send_wit_changed_to_state_chart)

	alc.animated_sprite.animation_finished.connect(_anim_collect_plant_finished)

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


func _send_5_sec_passed_to_state_chart():
	state_chart.send_event("5_sec_passed")

func _send_wit_changed_to_state_chart():
	state_chart.set_expression_property('current_wit', alc.wit.current_value)
	state_chart.send_event("wit_changed")


func _anim_collect_plant_finished():
	if alc.animated_sprite.animation == 'collect_plant':
		state_chart.send_event("anim_collect_plant_finished")