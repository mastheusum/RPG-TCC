extends PlayerBase

class_name PlayerMelee

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		$AnimationTree['parameters/conditions/Attacking'] = event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT
