extends Control

var inventory_slot = preload("res://Instances/GUI/inventory_slot_gui.tscn")
@onready var head : TextureRect = $Equipments/Head/Icon
@onready var weapon : TextureRect = $Equipments/Weapon/Icon
@onready var chest : TextureRect = $Equipments/Chest/Icon
@onready var legs : TextureRect = $Equipments/Legs/Icon
@onready var offhand : TextureRect = $Equipments/Offhand/Icon

func _ready() -> void:
	ManageInventory.connect("update_inventory", fill_inventory)
	ManageInventory.connect("update_equiped_item", update_equiped_item)
	free_inventory()
	fill_inventory()

func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("control_inventory"):
		visible = not visible

func free_inventory():
	for slot in $Panel/ScrollContainer/Grid.get_children():
		slot.queue_free()

func fill_inventory():
	free_inventory()
	for slot in ManageInventory.inventory.item_list:
		slot = slot as ItemSlot
		create_slot(slot.item, slot.amount)

func create_slot(item : Item, amount):
	var slot = inventory_slot.instantiate()
	slot.get_node("Icon").texture = item.sprite
	slot.get_node("Amount").text = "[right] %d" % amount
	slot.item = item
	$Panel/ScrollContainer/Grid.add_child(slot)

func update_equiped_item(type : Item.ItemType, icon : Texture2D):
	match type:
		Item.ItemType.HEAD:
			head.texture = icon
		Item.ItemType.WEAPON:
			weapon.texture = icon
		Item.ItemType.CHEST:
			chest.texture = icon
		Item.ItemType.LEGS:
			legs.texture = icon
		Item.ItemType.OFFHAND:
			offhand.texture = icon

func _on_head_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_action_pressed("right_mouse_action"):
			ManageInventory.unequip_item(Item.ItemType.HEAD)

func _on_chest_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_action_pressed("right_mouse_action"):
			ManageInventory.unequip_item(Item.ItemType.CHEST)

func _on_legs_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_action_pressed("right_mouse_action"):
			ManageInventory.unequip_item(Item.ItemType.LEGS)

func _on_weapon_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_action_pressed("right_mouse_action"):
			ManageInventory.unequip_item(Item.ItemType.WEAPON)

func _on_offhand_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_action_pressed("right_mouse_action"):
			ManageInventory.unequip_item(Item.ItemType.OFFHAND)
