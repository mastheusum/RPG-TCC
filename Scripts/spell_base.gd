extends Node2D

class_name SpellBase

@export var power : float = 5

var targets_entered : Array[EnemyBase] = []

func _ready() -> void:
	$AnimatedSprite2D.play("default")

func _on_end_spell() -> void:
	get_parent().remove_child(self)
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		targets_entered.append(body as EnemyBase)

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		targets_entered.erase(body as EnemyBase)

func _process(delta: float) -> void:
	var t = $EndSpell.time_left / $EndSpell.wait_time
	$ColorRect.color = Color(1, t, t)

func _on_tick_timeout() -> void:
	for target in targets_entered:
		target.take_damage( power )
