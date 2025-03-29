extends Area2D


func _ready() -> void:
	$Animation.play("default")

func _on_animation_animation_finished() -> void:
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		print("INIMIGOOOO")
