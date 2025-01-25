extends CharacterBody2D
class_name Ball


const STARTING_SPEED: float = 5.0
const SPEED_INCREASE_PERCENT: float = 1.01


func _ready():
	GameManager.restart_pressed.connect(_reset_position)
	_reset_position()


func _reset_position():
	position = get_viewport_rect().size / 2
	var initial_velocity_x: float = [-STARTING_SPEED, STARTING_SPEED].pick_random()
	var initial_velocity_y: float = [-STARTING_SPEED, STARTING_SPEED].pick_random()
	velocity.x = initial_velocity_x
	velocity.y = initial_velocity_y


func _physics_process(_delta):
	var collided_node = move_and_collide(velocity)
	if collided_node:
		velocity = velocity.bounce(collided_node.get_normal())
		velocity *= SPEED_INCREASE_PERCENT
		if collided_node.get_collider() is Paddle:
			GlobalAudioStreamPlayer.play_sound(GlobalAudioStreamPlayer.Sfx.PADDLE_HIT)
		elif collided_node.get_collider() is Wall:
			GlobalAudioStreamPlayer.play_sound(GlobalAudioStreamPlayer.Sfx.WALL_HIT)


func _on_visible_on_screen_notifier_2d_screen_exited():
	if position.x < 0:
		GameManager.score_point(GameManager.Player.ONE)
	else:
		GameManager.score_point(GameManager.Player.TWO)
	GlobalAudioStreamPlayer.play_sound(GlobalAudioStreamPlayer.Sfx.SCORE)
	queue_free()
