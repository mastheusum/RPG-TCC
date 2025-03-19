extends Resource

class_name Inventory

@export var item_list : Array[ItemSlot]

func add_item(item : Item, amount : int):
	var _has_item = false
	var _slot_index = -1
	for content in item_list:
		var it = content.item as Item
		if it.identification == item.identification:
			_has_item = true
			_slot_index = item_list.find(content)
			break
	
	if _has_item:
		item_list[_slot_index].amount += amount
		return
	
	var slot = ItemSlot.new()
	slot.item = item
	slot.amount = amount
	item_list.append(slot)
	
