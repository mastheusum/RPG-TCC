extends Timer

@export var enemy : PackedScene
@export var min_pos : Vector2
@export var max_pos : Vector2

func _on_timeout() -> void:
	var clone = enemy.instantiate()
	clone.global_position.x = randi_range(min_pos.x, max_pos.x)
	clone.global_position.y = randi_range(min_pos.y, max_pos.y)
	get_parent().add_child(clone)
