extends Control

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("ui_cancel"):
		_on_Button_pressed()

func _on_Button_pressed():
	GM.running_status = GM.IDLE
