extends Node

var inventory : Inventory = Inventory.new()

func add_item(item, amount):
	inventory.add_item(item, amount)
	for slot in inventory.item_list:
		print(slot.item.identification, slot.amount)
