extends CanvasLayer

onready var game_name = $ColorRect/CenterContainer/VBoxContainer/GameName

func _ready():
	GLOBAL_PLAYER_STATUS.running_status = GLOBAL_PLAYER_STATUS.IDLE
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
	GLOBAL_PLAYER_STATUS.running_status = GLOBAL_PLAYER_STATUS.PLAYING
	get_tree().paused = false
	SCENE_CHANGER.change_scene_to("res://Scenes/Worlds/World1.tscn")

func _on_TestButton_pressed():
	GLOBAL_PLAYER_STATUS.running_status = GLOBAL_PLAYER_STATUS.TEST
	SCENE_CHANGER.change_scene_to("res://Scenes/FakeGame.tscn")

func _on_QuitButton_pressed():
	GLOBAL_PLAYER_STATUS.quit_game()
