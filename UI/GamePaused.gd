extends ColorRect


func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		GM.running_status = GM.UNPAUSE
		queue_free()
	if Input.is_action_just_pressed("ui_cancel"):
		_on_BackButton_pressed()

func _on_BackButton_pressed():
	GM.running_status = GM.IDLE
	queue_free()
