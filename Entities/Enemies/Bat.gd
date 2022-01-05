extends KinematicBody2D

export(int) var MAX_HEALTH: float = 2.0
export(int) var MAX_SPEED: float = 50.0
export(int) var ACCELERATION: float = 10.0
export(int) var AIR_FRICTION: float = 10.0
export(int) var WEIGHT: float = 45.0

onready var bat_status = $Status
onready var wander_controller = $WanderController
onready var animate = $BatAnimatedSprite
onready var animation_blink = $BlinkAnimationPlayer
onready var hurtbot = $Hurtbox
onready var soft_collision = $SoftCollision
onready var player_detection = $PlayerDetectionZone

var action_state = IDLE

const ENEMY_DEATH_EFFECT_SCENE = preload("res://Entities/Enemies/EnemyDeathEffect.tscn")

enum { IDLE, WANDER, CHASE }

var move_velocity: Vector2 = Vector2.ZERO
var knockback_velocity: Vector2 = Vector2.ZERO

func create_death_effect():
	var enemy_death_effect = ENEMY_DEATH_EFFECT_SCENE.instance()
	get_parent().add_child(enemy_death_effect)
	enemy_death_effect.global_position = global_position

func update_wander():
	action_state = UTILS.shuffle_and_draw([IDLE, WANDER])
	wander_controller.start_wander()

func alert_around():
	if player_detection.can_see_player(): # 检测玩家
		action_state = CHASE
	elif wander_controller.is_idling():
		update_wander()

func move_to_point(point_position: Vector2):
	var face_vector: Vector2 = global_position.direction_to(point_position).normalized()
	move_velocity = move_velocity.move_toward(face_vector * MAX_SPEED, ACCELERATION)
	animate.flip_h = move_velocity.x < 0

func idle_state():
	move_velocity = move_velocity.move_toward(Vector2.ZERO, AIR_FRICTION)
	move_velocity = move_and_slide(move_velocity)
	alert_around()

func wander_state():
	move_to_point(wander_controller.target_position)
	if global_position.distance_to(wander_controller.target_position) <= 4:
		update_wander()
	alert_around()

func chase_state():
	var player = player_detection.player
	if player != null:
		move_to_point(player.global_position)
	else:
		action_state = IDLE

func _ready():
	bat_status.max_health = MAX_HEALTH
	bat_status.health = bat_status.max_health

func _physics_process(_delta):
	knockback_velocity = knockback_velocity.move_toward(Vector2.ZERO, AIR_FRICTION)
	knockback_velocity = move_and_slide(knockback_velocity)
	match action_state:
		IDLE:
			idle_state()
		WANDER:
			wander_state()
		CHASE:
			chase_state()
	if soft_collision.is_colliding():
		move_velocity += soft_collision.gen_push_vector() * 10
	move_velocity = move_and_slide(move_velocity)

func _on_Hurtbox_area_entered(area):
	bat_status.health -= area.DAMAGE
	hurtbot.start_invincibility(0.5, true)
	hurtbot.create_hit_effect()
	knockback_velocity = area.knockback_vector * (area.KNOCKBACK_POWER - WEIGHT) * 4

func _on_Status_no_health():
	queue_free()
	create_death_effect()

func _on_Hurtbox_invincibility_started(blink: bool):
	if blink:
		animation_blink.play("Blink")

func _on_Hurtbox_invincibility_ended():
	animation_blink.play("RESET")
