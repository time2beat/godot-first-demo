extends Node

export(int) var max_health: float = 1.0 setget set_max_health

signal max_health_changed(new_value)
signal health_changed(new_value)
signal no_health

var health: float = max_health setget set_health

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
