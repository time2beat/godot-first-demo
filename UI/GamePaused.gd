extends ColorRect


func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		_on_ResumeButton_pressed()
	if Input.is_action_just_pressed("ui_cancel"):
		_on_BackButton_pressed()

func _on_ResumeButton_pressed():
	GM.running_status = GM.UNPAUSE
	queue_free()

func _on_BackButton_pressed():
	GM.running_status = GM.IDLE
	queue_free()
