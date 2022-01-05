extends Node2D

const GRASS_EFFECT_SCENE = preload("res://Environments/GrassEffect.tscn")

func create_grass_effect():
	var grass_effect = GRASS_EFFECT_SCENE.instance()
	get_parent().add_child(grass_effect)
	grass_effect.global_position = global_position

func _on_Hurtbox_area_entered(_area):
	create_grass_effect()
	queue_free()
