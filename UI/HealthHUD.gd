extends Control

var max_hearts: float = 4.0 setget set_max_hearts
var hearts: float = max_hearts setget set_hearts

onready var label = $HealthLabel
onready var max_health_hud = $EmptyHeart
onready var health_hud = $FullHeart

func update_hearts_text(now_hearts: float, now_max_hearts: float):
	if label != null:
		label.text = "HP = " + str(now_hearts) + "/" + str(now_max_hearts)

func set_max_hearts(new_max_hearts: float):
	max_hearts = max(new_max_hearts, 1) # 设置血量上限最小为 1
	update_hearts_text(hearts, max_hearts)
	if max_health_hud != null:
		max_health_hud.rect_size.x = max_hearts * 15

func set_hearts(new_hearts: float):
	hearts = clamp(new_hearts, 0.0, max_hearts) # 设置血量在 0 和上限之间
	update_hearts_text(hearts, max_hearts)
	if health_hud != null:
		health_hud.rect_size.x = hearts * 15

func _ready():
	# warning-ignore:return_value_discarded
	GLOBAL_PLAYER_STATUS.connect("max_health_changed", self, "set_max_hearts")
	# warning-ignore:return_value_discarded
	GLOBAL_PLAYER_STATUS.connect("health_changed", self, "set_hearts")
	self.max_hearts = GLOBAL_PLAYER_STATUS.max_health
	self.hearts = GLOBAL_PLAYER_STATUS.health
	update_hearts_text(hearts, max_hearts)
