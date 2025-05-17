extends CharacterBody2D

class_name EnemyBase

@export_category('Enemy')
@export var life_max : float = 100
@export var speed : float = 100.0
@export var physic_defense : float = 2
@export var power : float = 5
@export var patrol_points : Array[Node2D]

var _life : float = 0
var _target : Node2D = null
var _patrol_index : int = 0
var _next_pos : Vector2

@onready var daddy : Node2D = get_parent()
@onready var agent : NavigationAgent2D = $Agent
@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	$FollowArea.connect("body_entered", body_entered)
	$FollowArea.connect("body_exited", body_exited)
	await get_tree().physics_frame
	_life = life_max

func body_entered(body : Node2D):
	if body.is_in_group("Player"):
		_target = body

func body_exited(body : Node2D):
	if body.is_in_group("Player"):
		_target = null

func _physics_process(delta: float) -> void:
	if _life <= 0:
		return
	
	if not _target:
		_patrol()
	elif global_position.distance_to(_target.global_position) >= 50:
		_pursuit()
	else:
		_attack()
	
	if velocity.x > 0:
		sprite.flip_h = false
	elif velocity.x < 0:
		sprite.flip_h = true
	
	#var collider = get_last_slide_collision().get_collider() as Node2D
	#if collider:
		#if collider.is_in_group("Player"):
			#collider = collider as PlayerBase
			#collider.take_damage(power)
			#dead()

func _patrol():
	if patrol_points.size() <= 0:
		return
	
	if agent.is_navigation_finished():
		agent.target_position = patrol_points[_patrol_index].global_position
		_patrol_index = (_patrol_index + 1) % patrol_points.size()
	
	_next_pos = agent.get_next_path_position()
	
	velocity = global_position.direction_to(_next_pos) * speed * 0.7
	move_and_slide()

func _pursuit():
	agent.target_position = _target.global_position
	_next_pos = agent.get_next_path_position()
	
	velocity = global_position.direction_to(_next_pos) * speed 
	move_and_slide()

func _attack():
	pass

func take_damage(damage):
	_life -= damage
	if _life <= 0:
		_target.gain_exp(1)
		dead()

func dead():
	#daddy.alive = false
	$CollisionShape2D.disabled = true
	$AnimatedSprite2D.visible = false

func live():
	#daddy.alive = true
	$CollisionShape2D.disabled = false
	$AnimatedSprite2D.visible = true
	_life = life_max
