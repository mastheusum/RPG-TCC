extends Area2D

class_name BaseSpell

func _ready() -> void:
	_on_ready()
	$Animation.play("default")

func _on_ready():
	pass
