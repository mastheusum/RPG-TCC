extends CharacterBody2D

class_name PlayerBase

var speed = 200
var direction := Vector2()

func _physics_process(delta: float) -> void:
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction.normalized() * speed
	move_and_slide()

func _process(delta: float) -> void:
	$AttackOffset.look_at( get_global_mouse_position() )
