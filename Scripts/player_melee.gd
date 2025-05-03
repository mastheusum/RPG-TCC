extends PlayerBase

class_name PlayerMelee

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		$AnimationTree['parameters/conditions/Attacking'] = event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT

func _on_damage_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		#body.take_damage(randi_range(power_min, power_max))
		var attack = PlayerAttributes.physic_power + ManageInventory.get_attack() + physic_attack_bonus
		body.take_damage(randi_range(attack, attack + PlayerAttributes.physic_power_delta))
