extends PlayerBase

class_name PlayerRanged

@export var shoot_preload : PackedScene
@export var shoot_speed : float
@export var delay_to_free : float

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
			shooting()

func shooting():
	var power = randf_range(PlayerAttributes.physic_power, PlayerAttributes.physic_power + PlayerAttributes.physic_power_delta)
	var shoot = shoot_preload.instantiate() as ProjectileMovement
	shoot.global_position = self.global_position
	shoot.speed = shoot_speed
	shoot.power = power
	get_parent().add_child(shoot)
