extends Label

@export var player: GameManager.Player

func _input(event):
	match player:
		GameManager.Player.ONE:
			if event.is_action_released("p1_input_toggle"):
				visible = !visible
		GameManager.Player.TWO:
			if event.is_action_released("p2_input_toggle"):
				visible = !visible
