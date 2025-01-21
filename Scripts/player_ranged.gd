extends PlayerBase

class_name PlayerRanged

@export var shoot_pre : PackedScene
@export var shoot_speed : float
@export var delay_to_free : float
@export var damage : int

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
			shooting()

func shooting():
	var shoot = shoot_pre.instantiate() as ProjectileMovement
	shoot.global_position = self.global_position
	shoot.speed = shoot_speed
	get_parent().add_child(shoot)
