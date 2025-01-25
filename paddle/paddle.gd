extends CharacterBody2D
class_name Paddle


const SPEED: float = 500.0
const PADDLE_HEIGHT: float = 60.0

var is_player_controlled: bool = false
var ai_direction_preference: float = 1.0

@export var player: GameManager.Player


func _ready():
	GameManager.restart_pressed.connect(_reset_position)


func _reset_position():
	position.y = get_viewport_rect().size.y / 2


func _input(event):
	match player:
		GameManager.Player.ONE:
			if event.is_action_released("p1_input_toggle"):
				is_player_controlled = !is_player_controlled
		GameManager.Player.TWO:
			if event.is_action_released("p2_input_toggle"):
				is_player_controlled = !is_player_controlled


func _physics_process(_delta):
	var direction: float
	if is_player_controlled:
		direction = _get_player_input()
	else:
		direction = _get_ai_command()
	if direction:
		velocity.y = direction * SPEED
	else:
		velocity.y = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _get_player_input() -> float:
	var direction: float = 0.0
	match player:
		GameManager.Player.ONE:
			direction = Input.get_axis("p1_up", "p1_down")
		GameManager.Player.TWO:
			direction = Input.get_axis("p2_up", "p2_down")
	return direction


func _get_ai_command() -> float:
	var direction: float = 0.0
	var target: float = 0.0
	if GameManager.current_ball != null:
		target = GameManager.current_ball.position.y
		if target > position.y + (PADDLE_HEIGHT / 2):
			direction = 1.0
		elif target < position.y - (PADDLE_HEIGHT / 2):
			direction = -1.0
		else:
			direction = ai_direction_preference
	return direction


func _on_ai_direction_preference_switcher_timeout():
	ai_direction_preference = [-0.25, 0.25].pick_random()
	$AIDirectionPreferenceSwitcher.wait_time = randf_range(1.0, 5.0)
