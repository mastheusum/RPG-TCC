extends Area2D

var damage_tween : Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	damage_tween = get_tree().create_tween()
	damage_tween.tween_property(
		$Circle, "scale", Vector2(0.3, 0.3), 1
	)
	damage_tween.tween_callback(_result)

func _result():
	$Circle.visible = false
	$Fissure.visible = true
	$CollisionShape2D.disabled = false
	damage_tween = get_tree().create_tween()
	damage_tween.tween_property(
		$Fissure, "modulate", Color.TRANSPARENT, 3
	)
	damage_tween.tween_callback(_end)

func _end():
	$CollisionShape2D.disabled = true
	print(1)
