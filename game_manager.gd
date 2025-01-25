extends Node

signal score_changed()
signal restart_pressed()

enum Player {
	ONE,
	TWO
}

const BALL_SCENE: PackedScene = preload("res://ball/ball.tscn")
const BALL_SPAWN_DELAY: float = 0.5

var p1_score: int = 0
var p2_score: int = 0

var current_ball: Ball


func _input(event):
	if event.is_action_released("restart_game"):
		p1_score = 0
		p2_score = 0
		score_changed.emit()
		restart_pressed.emit()
		GlobalAudioStreamPlayer.play_sound(GlobalAudioStreamPlayer.Sfx.RESTART)


func score_point(player: Player):
	match player:
		Player.ONE:
			p1_score += 1
		Player.TWO:
			p2_score += 1
	score_changed.emit()
	_spawn_ball()


func _ready():
	_spawn_ball()


func _spawn_ball():
	await get_tree().create_timer(BALL_SPAWN_DELAY).timeout
	var new_ball = BALL_SCENE.instantiate()
	new_ball.position = get_viewport().get_visible_rect().size / 2
	current_ball = new_ball
	get_tree().root.add_child(new_ball)
