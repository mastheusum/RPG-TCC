extends Control

var inventory_slot = preload("res://Instances/GUI/inventory_slot_gui.tscn")

func _ready() -> void:
	ManageInventory.connect("update_inventory", fill_inventory)
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
