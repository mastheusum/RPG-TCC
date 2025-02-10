extends CharacterBody2D

class_name EnemyBase

@export var life_max : float = 0
@onready var life : float = life_max

@onready var agent : NavigationAgent2D = $Agent
@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
var speed = 100.0
var target : Node2D = null
var attack : float = 5
var _next_pos : Vector2

func _ready() -> void:
	target = get_parent().get_node("Player")
	agent.target_position = target.global_position

func _physics_process(delta: float) -> void:
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
			queue_free()

func take_damage(damage):
	life -= damage
	if life <= 0:
		target.gain_exp(1)
		queue_free()
