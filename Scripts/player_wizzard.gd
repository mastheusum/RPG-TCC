extends PlayerBase

class_name PlayerWizzard

@export var spell_preload : PackedScene
@export var shoot_speed : float
@export var delay_to_free : float

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
			shooting()

func shooting():
	var shoot = spell_preload.instantiate() as SpellBase
	shoot.global_position = get_global_mouse_position()
	shoot.power_min = power_min
	shoot.power_max = power_max
	get_parent().add_child(shoot)
