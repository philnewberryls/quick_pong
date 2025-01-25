extends AudioStreamPlayer

const paddle_hit_sfx: AudioStreamWAV = preload("res://sfx/paddle_hit.wav")
const restart_sfx: AudioStreamWAV = preload("res://sfx/restart.wav")
const score_sfx: AudioStreamWAV = preload("res://sfx/score.wav")
const wall_hit_sfx: AudioStreamWAV = preload("res://sfx/wall_hit.wav")

enum Sfx {
	PADDLE_HIT,
	RESTART,
	SCORE,
	WALL_HIT
}


func play_sound(sfx: Sfx):
	match sfx:
		Sfx.PADDLE_HIT:
			stream = paddle_hit_sfx
		Sfx.RESTART:
			stream = restart_sfx
		Sfx.SCORE:
			stream = score_sfx
		Sfx.WALL_HIT:
			stream = wall_hit_sfx
	play()
