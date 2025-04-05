extends Area2D

var damage_increase : float = 0

func _ready() -> void:
	$Animation.play("default")

func _on_animation_animation_finished() -> void:
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		body.take_damage(damage_increase + randf_range(PlayerAttributes.physic_power, PlayerAttributes.physic_power + PlayerAttributes.physic_power_delta))
