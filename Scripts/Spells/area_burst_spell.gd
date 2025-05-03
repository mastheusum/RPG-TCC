extends BaseSpell

class_name AreaBurstSpell

var power : float = 0

func _on_ready():
	connect("body_entered", _on_body_entered)
	$Animation.connect("animation_finished", _on_animation_finished)

func _on_animation_finished() -> void:
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		body.take_damage(power + randf_range(
			PlayerAttributes.physic_power, 
			PlayerAttributes.physic_power + 
			PlayerAttributes.physic_power_delta)
		)
