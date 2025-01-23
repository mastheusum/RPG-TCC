extends CharacterBody2D

@onready var agent : NavigationAgent2D = $Agent
var speed = 100.0
var target : Node2D = null

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
