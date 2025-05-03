extends CharacterBody2D

class_name ProjectileMovement

@export var speed : float
@export var delay_to_free : float
@export var power : float

func _ready() -> void:
	$TimerToFree.start(delay_to_free)
	$AnimatedSprite2D.play("default")
	look_at( get_global_mouse_position() )

func _physics_process(delta: float) -> void:
	velocity = Vector2.RIGHT.rotated(rotation) * speed
	move_and_slide()
	
	for i in get_slide_collision_count():
		var collider = get_slide_collision(i).get_collider() as Node2D
		if collider.is_in_group("Enemy"):
			collider.take_damage(power)
			queue_free()

func _on_timer_to_free_timeout() -> void:
	get_parent().remove_child(self)
	queue_free()
