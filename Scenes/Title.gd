extends CanvasLayer

onready var game_name = $ColorRect/CenterContainer/VBoxContainer/GameName

func _ready():
	# TODO 设置 rect 未生效 切换场景后自动重置
	game_name.set("parameters/rect_scale/x", 2)
	#game_name.set("rect_scale/x", 2)
	game_name.rect_scale.y = 2

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		_on_StartButton_pressed()
	if Input.is_action_just_pressed("ui_cancel"):
		_on_QuitButton_pressed()

func _on_StartButton_pressed():
	GM.running_status = GM.PLAY

func _on_TestButton_pressed():
	GM.running_status = GM.TEST

func _on_QuitButton_pressed():
	GM.quit_game()
