extends Timer

@export var enemy : PackedScene
@export var spawn_points : Array[Node2D]

func _on_timeout() -> void:
	var clone = enemy.instantiate()
	var index = randi() % len(spawn_points)
	clone.global_position = spawn_points[index].global_position
	get_parent().add_child(clone)
