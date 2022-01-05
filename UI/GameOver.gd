extends ColorRect

func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		SCENE_CHANGER.change_scene_to("res://Scenes/Title.tscn")

func _on_BackButton_meta_clicked(meta: String):
	var meta_json: JSONParseResult = JSON.parse(meta)
	if typeof(meta_json.result) == TYPE_DICTIONARY:
		match meta_json.result.intent:
			"back_to_title":
				SCENE_CHANGER.change_scene_to("res://Scenes/Title.tscn")
	else:
		push_error("Unexpected results.")
