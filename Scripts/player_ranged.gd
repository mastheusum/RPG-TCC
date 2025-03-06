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
	var shoot = shoot_preload.instantiate() as ProjectileMovement
	shoot.global_position = self.global_position
	shoot.speed = shoot_speed
	shoot.power_min = PlayerAttributes.attack_base - PlayerAttributes.attack_delta
	shoot.power_max = PlayerAttributes.attack_base + PlayerAttributes.attack_delta
	get_parent().add_child(shoot)
