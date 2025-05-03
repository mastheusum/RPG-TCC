extends Control

func _ready() -> void:
	ManageInventory.connect("update_equiped_item", _change_skills)

func _process(delta: float) -> void:
	_check_cooldowns()

func _change_skills(item_type : Item.ItemType, icon):
	if icon:
		_add_skill_to_hud(item_type)
	else:
		_remove_skill_to_hud(item_type)

func _add_skill_to_hud(item_type : Item.ItemType):
	match item_type:
		Item.ItemType.WEAPON:
			if ManageInventory.weapon.item.hability:
				$"HBox/Skill 1/Icon".texture = ManageInventory.weapon.item.hability.icon
				$"HBox/Skill 1/Identification".text = "[center] %s" % ManageInventory.weapon.item.hability.identification
				$"HBox/Skill 1/CooldownTxt".text = ""
		Item.ItemType.OFFHAND:
			if ManageInventory.offhand.item.hability:
				$"HBox/Skill 2/Icon".texture = ManageInventory.offhand.item.hability.icon
				$"HBox/Skill 2/Identification".text = "[center] %s" % ManageInventory.offhand.item.hability.identification
		Item.ItemType.HEAD:
			if ManageInventory.head.item.hability:
				$"HBox/Skill 4/Icon".texture = ManageInventory.head.item.hability.icon
				$"HBox/Skill 4/Identification".text = "[center] %s" % ManageInventory.head.item.hability.identification
		Item.ItemType.CHEST:
			if ManageInventory.chest.item.hability:
				$"HBox/Skill 3/Icon".texture = ManageInventory.chest.item.hability.icon
				$"HBox/Skill 3/Identification".text = "[center] %s" % ManageInventory.chest.item.hability.identification
		Item.ItemType.LEGS:
			if ManageInventory.legs.item.hability:
				$"HBox/Skill 5/Icon".texture = ManageInventory.legs.item.hability.icon
				$"HBox/Skill 5/Identification".text = "[center] %s" % ManageInventory.legs.item.hability.identification

func _remove_skill_to_hud(item_type : Item.ItemType):
	match item_type:
		Item.ItemType.WEAPON:
			$"HBox/Skill 1/Icon".texture = null
			$"HBox/Skill 1/Identification".text = ""
		Item.ItemType.OFFHAND:
			$"HBox/Skill 2/Icon".texture = null
			$"HBox/Skill 2/Identification".text = ""
		Item.ItemType.HEAD:
			$"HBox/Skill 4/Icon".texture = null
			$"HBox/Skill 4/Identification".text = ""
		Item.ItemType.CHEST:
			$"HBox/Skill 3/Icon".texture = null
			$"HBox/Skill 3/Identification".text = ""
		Item.ItemType.LEGS:
			$"HBox/Skill 5/Icon".texture = null
			$"HBox/Skill 5/Identification".text = ""

func _check_cooldowns():
	if $"HBox/Skill 1/Cooldown".time_left > 0:
		$"HBox/Skill 1/CooldownTxt".text = "[center] %.1f" % $"HBox/Skill 1/Cooldown".time_left
	elif $"HBox/Skill 1/CooldownTxt".text != '':
		$"HBox/Skill 1/CooldownTxt".text = ''
		$"HBox/Skill 1/Icon".modulate = Color(1, 1, 1)
	
	if $"HBox/Skill 2/Cooldown".time_left > 0:
		$"HBox/Skill 2/CooldownTxt".text = "[center] %.1f" % $"HBox/Skill 2/Cooldown".time_left
	elif $"HBox/Skill 2/CooldownTxt".text != '':
		$"HBox/Skill 2/CooldownTxt".text = ''
		$"HBox/Skill 2/Icon".modulate = Color(1, 1, 1)
	
	if $"HBox/Skill 3/Cooldown".time_left > 0:
		$"HBox/Skill 3/CooldownTxt".text = "[center] %.1f" % $"HBox/Skill 3/Cooldown".time_left
	elif $"HBox/Skill 3/CooldownTxt".text != '':
		$"HBox/Skill 3/CooldownTxt".text = ''
		$"HBox/Skill 3/Icon".modulate = Color(1, 1, 1)
	
	if $"HBox/Skill 4/Cooldown".time_left > 0:
		$"HBox/Skill 4/CooldownTxt".text = "[center] %.1f" % $"HBox/Skill 4/Cooldown".time_left
	elif $"HBox/Skill 4/CooldownTxt".text != '':
		$"HBox/Skill 4/CooldownTxt".text = ''
		$"HBox/Skill 4/Icon".modulate = Color(1, 1, 1)
	
	if $"HBox/Skill 5/Cooldown".time_left > 0:
		$"HBox/Skill 5/CooldownTxt".text = "[center] %.1f" % $"HBox/Skill 5/Cooldown".time_left
	elif $"HBox/Skill 5/CooldownTxt".text != '':
		$"HBox/Skill 5/CooldownTxt".text = ''
		$"HBox/Skill 5/Icon".modulate = Color(1, 1, 1)

func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("use_skill_alpha_1") and ManageInventory.weapon.item 
		and ManageInventory.weapon.item.hability and $"HBox/Skill 1/Cooldown".time_left <= 0 and
		PlayerAttributes.consume_mana(ManageInventory.weapon.item.hability.mana)):
		var skill = ManageInventory.weapon.item.hability.prefab.instantiate()
		skill.power = ManageInventory.weapon.item.hability.power
		skill.global_position = PlayerBase.main_character.global_position
		PlayerBase.main_character.get_parent().add_child(skill)
		$"HBox/Skill 1/Cooldown".start(ManageInventory.weapon.item.hability.cooldown)
		$"HBox/Skill 1/Icon".modulate = Color(0.5, 0.5, 0.5)
	if (event.is_action_pressed("use_skill_alpha_2") and ManageInventory.offhand.item 
		and ManageInventory.offhand.item.hability and $"HBox/Skill 2/Cooldown".time_left <= 0 and
		PlayerAttributes.consume_mana(ManageInventory.offhand.item.hability.mana)):
		
		var skill = ManageInventory.offhand.item.hability.prefab.instantiate()
		skill.global_position = Vector2.ZERO
		PlayerBase.main_character.add_child(skill)
		$"HBox/Skill 2/Cooldown".start(ManageInventory.offhand.item.hability.cooldown)
		$"HBox/Skill 2/Icon".modulate = Color(0.5, 0.5, 0.5)
	if (event.is_action_pressed("use_skill_alpha_3") and ManageInventory.chest.item 
		and ManageInventory.chest.item.hability and $"HBox/Skill 3/Cooldown".time_left <= 0 and
		PlayerAttributes.consume_mana(ManageInventory.chest.item.hability.mana)):
		# a SKILL vindo do CHEST sempre será uma aura, logo precisa ser fixada ao
		# personagem para caso ele se locomova
		var skill = ManageInventory.chest.item.hability.prefab.instantiate()
		skill.power = ManageInventory.chest.item.hability.power
		skill.global_position = Vector2.ZERO
		PlayerBase.main_character.add_child(skill)
		$"HBox/Skill 3/Cooldown".start(ManageInventory.chest.item.hability.cooldown)
		$"HBox/Skill 3/Icon".modulate = Color(0.5, 0.5, 0.5)
	if (event.is_action_pressed("use_skill_alpha_4") and ManageInventory.head.item 
		and ManageInventory.head.item.hability and $"HBox/Skill 4/Cooldown".time_left <= 0 and
		PlayerAttributes.consume_mana(ManageInventory.head.item.hability.mana)):
		# a SKILL vindo do CHEST sempre será uma aura, logo precisa ser fixada ao
		# personagem para caso ele se locomova
		var skill = ManageInventory.head.item.hability.prefab.instantiate()
		skill.power = ManageInventory.head.item.hability.power
		skill.global_position = Vector2.ZERO
		PlayerBase.main_character.add_child(skill)
		$"HBox/Skill 4/Cooldown".start(ManageInventory.head.item.hability.cooldown)
		$"HBox/Skill 4/Icon".modulate = Color(0.5, 0.5, 0.5)
	if (event.is_action_pressed("use_skill_alpha_5") and ManageInventory.legs.item 
		and ManageInventory.legs.item.hability and $"HBox/Skill 5/Cooldown".time_left <= 0 and
		PlayerAttributes.consume_mana(ManageInventory.legs.item.hability.mana)):
		
		var skill = ManageInventory.legs.item.hability.prefab.instantiate()
		skill.global_position = Vector2.ZERO
		PlayerBase.main_character.add_child(skill)
		$"HBox/Skill 5/Cooldown".start(ManageInventory.legs.item.hability.cooldown)
		$"HBox/Skill 5/Icon".modulate = Color(0.5, 0.5, 0.5)
