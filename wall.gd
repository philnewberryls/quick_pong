extends StaticBody2D
class_name Wall

enum Place {
	TOP,
	BOTTOM
}

const COLOR_RECT_HEIGHT: float = 10.0

@export var placement: Place


func _ready():
	_configure_placement()
	get_tree().root.size_changed.connect(_configure_placement)


func _configure_placement():
	if placement == Place.TOP:
		position.y = 0
	else:
		position.y = get_viewport_rect().size.y - COLOR_RECT_HEIGHT
	$ColorRect.size.x = get_viewport_rect().size.x
	$ColorRect.size.y = COLOR_RECT_HEIGHT
