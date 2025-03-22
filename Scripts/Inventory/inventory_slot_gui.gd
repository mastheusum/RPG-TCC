extends NinePatchRect

var mouse_enter : bool = false
var item : Item

func _on_mouse_entered() -> void:
	mouse_enter = true

func _on_mouse_exited() -> void:
	mouse_enter = false

func _process(delta: float) -> void:
	if mouse_enter and Input.is_action_just_pressed("right_mouse_action"):
		ManageInventory.equip_item(item)
		
