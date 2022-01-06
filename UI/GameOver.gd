extends ColorRect

func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		GM.running_status = GM.IDLE

func _on_BackButton_meta_clicked(meta: String):
	var meta_json: JSONParseResult = JSON.parse(meta)
	if typeof(meta_json.result) == TYPE_DICTIONARY:
		match meta_json.result.intent:
			"back_to_title":
				GM.running_status = GM.IDLE
	else:
		push_error("Unexpected results.")
