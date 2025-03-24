extends Node

@export var inventory : Inventory

@export var head : ItemSlot = ItemSlot.new()
@export var chest : ItemSlot = ItemSlot.new()
@export var arms : ItemSlot = ItemSlot.new()
@export var legs : ItemSlot = ItemSlot.new()
@export var weapon : ItemSlot = ItemSlot.new()
@export var offhand : ItemSlot = ItemSlot.new()

signal update_inventory
signal update_equiped_item(slot : Item.ItemType, icon : Texture2D)

func _init() -> void:
	if inventory == null:
		inventory = Inventory.new()

func add_item(item : Item, amount):
	inventory.add_item(item, amount)
	emit_signal("update_inventory")

func remove_item(item : Item, amount):
	inventory.remove_item(item, amount)
	emit_signal('update_inventory')

func equip_item(item : Item):
	match item.type:
		Item.ItemType.HEAD:
			if head.item:
				inventory.add_item(head.item, 1)
			inventory.remove_item(item, 1)
			head.item = item
		Item.ItemType.WEAPON:
			if weapon.item:
				inventory.add_item(weapon.item, 1)
			inventory.remove_item(item, 1)
			weapon.item = item
		Item.ItemType.CHEST:
			if chest.item:
				inventory.add_item(chest.item, 1)
			inventory.remove_item(item, 1)
			chest.item = item
		Item.ItemType.ARMS:
			if arms.item:
				inventory.add_item(arms.item, 1)
			inventory.remove_item(item, 1)
			arms.item = item
		Item.ItemType.LEGS:
			if legs.item:
				inventory.add_item(legs.item, 1)
			inventory.remove_item(item, 1)
			legs.item = item
		Item.ItemType.OFFHAND:
			if arms.offhand:
				inventory.add_item(offhand.item, 1)
			inventory.remove_item(item, 1)
			offhand.item = item
			
	emit_signal('update_inventory')
	emit_signal("update_equiped_item", item.type, item.sprite)
