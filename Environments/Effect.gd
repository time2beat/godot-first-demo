extends AnimatedSprite

func _ready():
	if self.connect("animation_finished", self, "_on_animation_finished") == OK:
		play("Effect")

func _on_animation_finished():
	queue_free()
