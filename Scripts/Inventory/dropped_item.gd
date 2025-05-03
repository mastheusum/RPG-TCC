extends Node2D

@export var item : Item
@export var amount : int

func _ready() -> void:
	if not item:
		return
	
	$Sprite2D.texture = item.sprite
	$Area2D.connect("body_entered", collect_item)

func collect_item(body : Node2D):
	print(body.get_groups())
	if body.is_in_group("Player"):
		ManageInventory.add_item(item, amount)
		queue_free()
