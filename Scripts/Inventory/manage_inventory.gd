extends Node

@export var inventory : Inventory

@export var head : ItemSlot = ItemSlot.new()
@export var chest : ItemSlot = ItemSlot.new()
@export var legs : ItemSlot = ItemSlot.new()
@export var weapon : ItemSlot = ItemSlot.new()
@export var offhand : ItemSlot = ItemSlot.new()

signal update_inventory
signal update_equiped_item(slot : Item.ItemType, icon : Texture2D)

func _init() -> void:
	if inventory == null:
		inventory = Inventory.new()

func _ready() -> void:
	connect("update_equiped_item", PlayerAttributes._update_status_by_equipment)

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
		Item.ItemType.LEGS:
			if legs.item:
				inventory.add_item(legs.item, 1)
			inventory.remove_item(item, 1)
			legs.item = item
		Item.ItemType.OFFHAND:
			if offhand.item:
				inventory.add_item(offhand.item, 1)
			inventory.remove_item(item, 1)
			offhand.item = item
			
	emit_signal('update_inventory')
	emit_signal("update_equiped_item", item.type, item.sprite)

func unequip_item(slot : Item.ItemType):
	match slot:
		Item.ItemType.HEAD:
			add_item(head.item, 1)
			head.item = null
		Item.ItemType.CHEST:
			add_item(chest.item, 1)
			chest.item = null
		Item.ItemType.LEGS:
			add_item(legs.item, 1)
			legs.item = null
		Item.ItemType.WEAPON:
			add_item(weapon.item, 1)
			weapon.item = null
		Item.ItemType.OFFHAND:
			add_item(offhand.item, 1)
			offhand.item = null
	
	emit_signal('update_inventory')
	emit_signal("update_equiped_item", slot, null)

func get_defense():
	var val = 0
	for slot in [head, chest, legs, weapon, offhand]:
		if slot.item:
			val += (slot.item as Equipment).defense
	return val 

func get_attack():
	var val = 0
	for slot in [head, chest, legs, weapon, offhand]:
		if slot.item:
			val += (slot.item as Equipment).attack
	return val

func get_life():
	var val = 0
	for slot in [head, chest, legs, weapon, offhand]:
		if slot.item:
			val += (slot.item as Equipment).life
	return val

func get_mana():
	var val = 0
	for slot in [head, chest, legs, weapon, offhand]:
		if slot.item:
			val += (slot.item as Equipment).mana
	return val
