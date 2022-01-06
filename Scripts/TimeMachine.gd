extends Node

signal time_scale_changed

export(float) var time_scale: float = 1.0 setget set_time_scale

func set_time_scale(new_time_scale):
	time_scale = new_time_scale
	Engine.time_scale = time_scale
	AudioServer.global_rate_scale = 2.0 - time_scale
	emit_signal("time_scale_changed") # TODO 通知游戏
