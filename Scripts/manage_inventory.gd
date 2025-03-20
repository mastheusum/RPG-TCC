extends Node

@export var inventory : Inventory

signal update_inventory

func _init() -> void:
	if inventory == null:
		inventory = Inventory.new()

func add_item(item, amount):
	inventory.add_item(item, amount)
	#for slot in inventory.item_list:
	#	print(slot.item.identification, slot.amount)
	emit_signal("update_inventory")
