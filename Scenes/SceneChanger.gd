extends CanvasLayer

onready var animate = $AnimationPlayer
onready var mask = $ColorRect

func change_scene_to(path: String):
	mask.show()
	animate.play("Scene Change")
	yield(animate, "animation_finished")
	# warning-ignore:return_value_discarded
	get_tree().change_scene(path)
	animate.play_backwards("Scene Change")
	yield(animate, "animation_finished")
	mask.hide()
