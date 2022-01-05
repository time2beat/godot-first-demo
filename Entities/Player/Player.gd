extends KinematicBody2D

export(float) var MAX_SPEED = 100.0
export(float) var ROLL_SPEED = 125.0
export(float) var ACCELERATION = 10.0
export(float) var FRICTION = 25.0

var action_state = MOVE

onready var animation_state_machine = $FSMAnimationTree
onready var animation_state = animation_state_machine.get("parameters/playback")
onready var animation_blink = $BlinkAnimationPlayer
onready var sword_hitbox = $HitboxPivot/SwordHitbox
onready var hurtbot = $Hurtbox

enum { MOVE, ROLL, ATTACK }

var move_velocity: Vector2 = Vector2.ZERO
var face_vector: Vector2 = Vector2.DOWN

const PLAYER_HURT_SOUND_SCENE = preload("res://Entities/Player/PlayerHurtSound.tscn")
const GAME_OVER_SCENE = preload("res://UI/GameOver.tscn")

func do_move():
	move_velocity = move_and_slide(move_velocity)

func get_face_toward() -> Vector2:
	var vector: Vector2 = Vector2.ZERO
	vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	return vector.normalized()

func idle_or_move_state():
	var input_vector: Vector2 = get_face_toward()
	if input_vector != Vector2.ZERO:
		face_vector = input_vector
		sword_hitbox.knockback_vector = input_vector
		animation_state_machine.set("parameters/Idle/blend_position", face_vector)
		animation_state_machine.set("parameters/Run/blend_position", face_vector)
		animation_state_machine.set("parameters/Attack/blend_position", face_vector)
		animation_state.travel("Run")
		move_velocity = move_velocity.move_toward(face_vector * MAX_SPEED, ACCELERATION)
	else:
		animation_state.travel("Idle")
		move_velocity = move_velocity.move_toward(Vector2.ZERO, FRICTION)
	do_move()
	if Input.is_action_just_pressed("action_roll"):
		#GLOBAL_PLAYER_STATUS.max_health -= 1 # 测试动态减少血量上限
		action_state = ROLL
	if Input.is_action_just_pressed("action_attack"):
		action_state = ATTACK

func roll_state():
	animation_state_machine.set("parameters/Roll/blend_position", face_vector)
	move_velocity = face_vector * ROLL_SPEED
	animation_state.travel("Roll")
	hurtbot.start_invincibility(0.4)
	do_move()

func attack_state():
	move_velocity = Vector2.ZERO
	animation_state.travel("Attack")

func roll_animation_finished():
	action_state = MOVE

func attack_animation_finished():
	action_state = MOVE

func game_over():
	get_node("/root/World1/GUI").add_child(GAME_OVER_SCENE.instance())
	queue_free()

func _ready():
	GLOBAL_PLAYER_STATUS.connect("no_health", self, "game_over")
	GLOBAL_PLAYER_STATUS.health = GLOBAL_PLAYER_STATUS.max_health
	animation_state_machine.active = true
	sword_hitbox.knockback_vector = face_vector
	sword_hitbox.KNOCKBACK_POWER = 100.0

func _physics_process(_delta):
	#print("now face = ", face_vector)
	#print("now speed = ", move_velocity)
	#print("delta = ", delta)
	match action_state:
		MOVE:
			idle_or_move_state()
		ROLL:
			roll_state()
		ATTACK:
			attack_state()

func _on_Hurtbox_area_entered(area):
	GLOBAL_PLAYER_STATUS.health -= area.DAMAGE
	hurtbot.start_invincibility(1.0, true)
	hurtbot.create_hit_effect()
	get_parent().add_child(PLAYER_HURT_SOUND_SCENE.instance())

func _on_Hurtbox_invincibility_started(blink: bool):
	if blink:
		animation_blink.play("Blink")

func _on_Hurtbox_invincibility_ended():
	animation_blink.play("RESET")
