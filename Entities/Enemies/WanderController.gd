extends Node2D

export(int) var WANDER_RANGE: float = 32.0

onready var wander_timer = $WanderTimer
onready var alert_timer = $AlertTimer

onready var start_position: Vector2 = global_position
onready var target_position: Vector2 = global_position

func gen_random_coordinate() -> float:
	return rand_range(-WANDER_RANGE, WANDER_RANGE)

func update_new_target():
	var target_vector = Vector2(gen_random_coordinate(), gen_random_coordinate())
	target_position = start_position + target_vector
	#print("已更新新的巡逻地点 ", target_position)

func start_wander():
	update_new_target()
	wander_timer.start(rand_range(1, 3))

func stop_wander():
	print("到达巡逻地点 提前停止巡逻")
	wander_timer.stop()

func is_idling() -> bool:
	return wander_timer.is_stopped()# and alert_timer.is_stopped()

func _on_WanderTimer_timeout():
	#print("到达巡逻地点 开始站岗")
	#alert_timer.start(rand_range(3, 5))
	pass

func _on_AlertTimer_timeout():
	print("站岗结束 继续巡逻下一个地点")
