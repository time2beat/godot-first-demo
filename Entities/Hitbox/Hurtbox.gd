extends Area2D

signal invincibility_started(visibility)
signal invincibility_ended

var invincible: bool = false setget set_invincible
var visibility: bool = false

onready var collision = $CollisionHurtbox
onready var timer = $InvincibilityTimer

const HIT_EFFECT_SCENE = preload("res://Entities/HitEffect.tscn")

func set_invincible(is_invincible: bool):
	invincible = is_invincible
	if invincible:
		emit_signal("invincibility_started", visibility)
	else:
		emit_signal("invincibility_ended")

func start_invincibility(duration: float, enable_blink: bool = false):
	visibility = enable_blink
	self.invincible = true
	timer.start(duration)

func create_hit_effect():
	var hit_effect = HIT_EFFECT_SCENE.instance()
	var entities_node = get_node("/root/World1/Entities")
	entities_node.add_child(hit_effect)
	hit_effect.global_position = global_position - Vector2(0, 8)

func _on_InvincibilityTimer_timeout():
	self.invincible = false # 调用 self.set_invincible()

func _on_Hurtbox_invincibility_started(_visibility):
	collision.set_deferred("disabled", true) # 禁用受击碰撞箱(实质性无敌)

func _on_Hurtbox_invincibility_ended():
	collision.disabled = false # 重新开启受击碰撞箱(取消无敌)
