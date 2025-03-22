extends Node

@export var inventory : Inventory
@export var head : ItemSlot
@export var chest : ItemSlot
@export var arms : ItemSlot
@export var legs : ItemSlot
@export var weapon : ItemSlot
@export var offhand : ItemSlot

signal update_inventory

func _init() -> void:
	if inventory == null:
		inventory = Inventory.new()

func add_item(item, amount):
	inventory.add_item(item, amount)
	emit_signal("update_inventory")

func remove_item(item, amount):
	inventory.remove_item(item, amount)
	emit_signal('update_inventory')

func equip_item(item):
	if item.type == Item.ItemType.CHEST:
		if chest:
			inventory.add_item(chest.item, 1)
		inventory.remove_item(item, 1)
		var equip = ItemSlot.new()
		equip.item = item
		equip.amount = 1
		chest = equip
			
	emit_signal('update_inventory')
