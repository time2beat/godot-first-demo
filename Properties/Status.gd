extends Node

export(int) var max_health: float = 1.0 setget set_max_health

signal max_health_changed(new_value)
signal health_changed(new_value)
signal no_health

var running_status: int = IDLE
var health: float = max_health setget set_health

enum { IDLE, PLAYING, TEST }

const GAME_PAUSE_SCENE = preload("res://UI/GamePaused.tscn")

func set_max_health(new_max_health: float):
	max_health = new_max_health
	self.health = min(health, max_health)
	emit_signal("max_health_changed", max_health)

func set_health(new_health: float):
	health = new_health
	#print("get damage, health = ", health, " / ", max_health)
	emit_signal("health_changed", health)
	if health <= 0:
		emit_signal("no_health")

func quit_game():
	get_tree().quit()

func _physics_process(_delta):
	if running_status == PLAYING and health > 0 and get_tree().paused == false:
		if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("ui_cancel"):
			get_tree().paused = true
			get_node("/root/World1/GUI").add_child(GAME_PAUSE_SCENE.instance())
