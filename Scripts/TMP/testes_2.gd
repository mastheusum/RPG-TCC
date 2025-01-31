extends Control

var my_tween
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	my_tween = get_tree().create_tween()
	my_tween.tween_property(
		$ColorRect,
		"position",
		$ColorRect.position + Vector2(100, 100),
		2
	)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
