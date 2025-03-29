extends Control

func _ready() -> void:
	ManageInventory.connect("update_equiped_item", _update_skills)
	print(0)

func _update_skills(item_type : Item.ItemType, icon):
	print(1)
	match item_type:
		Item.ItemType.WEAPON:
			$"HBox/Skill 1/Icon".texture = ManageInventory.weapon.item.hability.icon
			$"HBox/Skill 1/CountDown".text = ""
			pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("use_skill_alpha_1"):
		pass
