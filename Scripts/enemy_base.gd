extends CharacterBody2D

class_name EnemyBase

var daddy : SpawnEnemy
var target : Node2D = null
@export var life_max : float = 100

var life : float = 0
var speed = 100.0
var attack : float = 5
var _next_pos : Vector2

@onready var agent : NavigationAgent2D = $Agent
@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	$FollowArea.connect("body_entered", body_entered)
	$FollowArea.connect("body_exited", body_exited)

func body_entered(body : Node2D):
	if body.is_in_group("Player"):
		target = body

func body_exited(body : Node2D):
	if body.is_in_group("Player"):
		target = null

func _physics_process(delta: float) -> void:
	if life <= 0 or target == null:
		return
	elif target != null:
		agent.target_position = target.global_position
	
	if not target or agent.is_navigation_finished():
		return
		
	agent.target_position = target.global_position
	_next_pos = agent.get_next_path_position()
	
	velocity = global_position.direction_to(_next_pos) * speed
	move_and_slide()
	
	if velocity.x > 0:
		sprite.flip_h = false
	elif velocity.x < 0:
		sprite.flip_h = true
	
	for i in get_slide_collision_count():
		var collider = get_slide_collision(i).get_collider() as Node2D
		if collider.is_in_group("Player"):
			collider = collider as PlayerBase
			collider.take_damage(attack)
			dead()

func take_damage(damage):
	life -= damage
	if life <= 0:
		target.gain_exp(1)
		dead()

func dead():
	daddy.alive = false
	$CollisionShape2D.disabled = true
	$AnimatedSprite2D.visible = false

func live():
	daddy.alive = true
	$CollisionShape2D.disabled = false
	$AnimatedSprite2D.visible = true
	life = life_max
