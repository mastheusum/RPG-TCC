extends Control

func _ready() -> void:
	ManageInventory.connect("update_equiped_item", _change_skills)
	print(0)

func _change_skills(item_type : Item.ItemType, icon):
	pass

func _add_skill_to_hud(item_type : Item.ItemType):
	match item_type:
		Item.ItemType.WEAPON:
			if ManageInventory.weapon.item:
				$"HBox/Skill 1/Icon".texture = ManageInventory.weapon.item.hability.icon
				$"HBox/Skill 1/CountDown".text = ""
			else:
				$"HBox/Skill 1/Icon".texture = null
				$"HBox/Skill 1/CountDown".text = ""
		Item.ItemType.OFFHAND:
			if ManageInventory.offhand.item:
				$"HBox/Skill 2/Icon".texture = ManageInventory.offhand.item.hability.icon
				$"HBox/Skill 2/CountDown".text = ""
			else:
				$"HBox/Skill 2/Icon".texture = null
				$"HBox/Skill 2/CountDown".text = ""
		Item.ItemType.HEAD:
			if ManageInventory.head.item:
				$"HBox/Skill 4/Icon".texture = ManageInventory.head.item.hability.icon
				$"HBox/Skill 4/CountDown".text = ""
			else:
				$"HBox/Skill 4/Icon".texture = null
				$"HBox/Skill 4/CountDown".text = ""
		Item.ItemType.CHEST:
			if ManageInventory.chest.item:
				$"HBox/Skill 3/Icon".texture = ManageInventory.chest.item.hability.icon
				$"HBox/Skill 3/CountDown".text = ""
			else:
				$"HBox/Skill 3/Icon".texture = null
				$"HBox/Skill 3/CountDown".text = ""
		Item.ItemType.LEGS:
			if ManageInventory.legs.item:
				$"HBox/Skill 5/Icon".texture = ManageInventory.legs.item.hability.icon
				$"HBox/Skill 5/CountDown".text = ""
			else:
				$"HBox/Skill 5/Icon".texture = null
				$"HBox/Skill 5/CountDown".text = ""
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("use_skill_alpha_1"):
		pass
