extends Label

@onready var visibility_timer: Timer = $VisiblityTimer


func _input(event):
	if event.is_action_released("p1_input_toggle") or event.is_action_released("p2_input_toggle"):
		visible = true
		visibility_timer.start()
	if event.is_action_released("restart_game"):
		visible = false


func _on_visiblity_timer_timeout():
	visible = false
