extends Node

var running_status: int = IDLE setget set_running_status

enum { IDLE, PLAY, UNPAUSE, PAUSE, END, TEST }

const GAME_PAUSE_SCENE = preload("res://UI/GamePaused.tscn")
const UNPAUSE_SOUND_SCENE = preload("res://UI/UnpauseSound.tscn")
const GAME_OVER_SCENE = preload("res://UI/GameOver.tscn")

func set_running_status(new_status: int):
	match new_status:
		IDLE:
			running_status = IDLE
			SCENE_CHANGER.change_scene_to("res://Scenes/Title.tscn")
		PLAY:
			PLAYER_STATUS.health = PLAYER_STATUS.max_health
			running_status = PLAY
			SCENE_CHANGER.change_scene_to("res://Scenes/Worlds/World1.tscn")
			get_tree().paused = false
		PAUSE:
			running_status = PAUSE
			get_tree().paused = true
			get_node("/root/World1/GUI").add_child(GAME_PAUSE_SCENE.instance())
		UNPAUSE:
			running_status = PLAY
			get_tree().paused = false
			get_parent().add_child(UNPAUSE_SOUND_SCENE.instance())
		END:
			running_status = END
			get_node("/root/World1/GUI").add_child(GAME_OVER_SCENE.instance())
		TEST:
			running_status = TEST
			SCENE_CHANGER.change_scene_to("res://Scenes/FakeGame.tscn")

func quit_game():
	get_tree().quit()

func _physics_process(_delta):
	match running_status:
		PLAY:
			if PLAYER_STATUS.health <= 0:
				self.running_status = END
			elif Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("ui_cancel"):
				self.running_status = PAUSE
