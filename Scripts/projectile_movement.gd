extends CharacterBody2D

class_name ProjectileMovement

@export var speed : float
@export var delay_to_free : float
@export var damage : int
var direction := Vector2()

func _ready() -> void:
	$TimerToFree.start(delay_to_free)
	direction = global_position.direction_to( get_global_mouse_position() )

func _physics_process(delta: float) -> void:
	velocity = direction * speed
	move_and_slide()


func _on_timer_to_free_timeout() -> void:
	get_parent().remove_child(self)
	queue_free()
