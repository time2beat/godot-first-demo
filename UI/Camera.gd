extends Camera2D

onready var top_left = $Separation/CameraLimitTopLeft
onready var bottom_right = $Separation/CameraLimitBottomRight

func _ready():
	limit_top = top_left.position.y
	limit_left = top_left.position.x
	limit_bottom = bottom_right.position.y
	limit_right = bottom_right.position.x
