extends Label


@export var player: GameManager.Player


func _ready():
	GameManager.score_changed.connect(update_value)


func update_value():
	if player == GameManager.Player.ONE:
		text = str(GameManager.p1_score)
	else:
		text = str(GameManager.p2_score)
