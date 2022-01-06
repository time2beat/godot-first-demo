extends Node

var running_status: int = IDLE setget set_running_status

onready var tween = $Tween

enum { IDLE, PLAY, UNPAUSE, PAUSE, END, TEST }

const GAME_PAUSE_SCENE = preload("res://UI/GamePaused.tscn")
const UNPAUSE_SOUND_SCENE = preload("res://UI/UnpauseSound.tscn")
const GAME_OVER_SCENE = preload("res://UI/GameOver.tscn")

func set_running_status(new_status: int) -> void:
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
			toggle_bullet_time(false)
			get_node("/root/World1/GUI").add_child(GAME_OVER_SCENE.instance())
		TEST:
			running_status = TEST
			SCENE_CHANGER.change_scene_to("res://Scenes/FakeGame.tscn")

func quit_game() -> void:
	get_tree().quit()

func toggle_bullet_time(enable: bool = false) -> void:
	tween.remove_all()
	var camera = get_node("/root/World1/GUI/Control/Camera2D")
	var camera_zoom: float = 0.85
	if enable:
		if camera != null:
			tween.interpolate_property(camera, "zoom", null, Vector2(camera_zoom, camera_zoom), 0.5)
		tween.interpolate_property(TIME_MACHINE, "time_scale", null, 0.2, 0.5)
	else:
		tween.interpolate_property(TIME_MACHINE, "time_scale", null, 1.0, 0.5)
		if camera != null:
			tween.interpolate_property(camera, "zoom", null, Vector2(1.0, 1.0), 0.5)
	tween.start()

func _physics_process(_delta) -> void:
	match running_status:
		PLAY:
			if PLAYER_STATUS.health > 0:
				if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("ui_cancel"):
					self.running_status = PAUSE
				elif Input.is_action_just_pressed("toggle_bullet_time"):
					# 使用补间提供渐变效果
					if TIME_MACHINE.time_scale == 1.0:
						toggle_bullet_time(true)
					else:
						toggle_bullet_time(false)
