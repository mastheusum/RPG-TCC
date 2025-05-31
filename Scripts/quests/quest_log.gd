extends Control

var quests : TreeItem

func _ready():
	quests = $Tree.create_item()
	quests.set_text(0, "Quest Log")
	var item1 = $Tree.create_item(quests)
	var item2 = $Tree.create_item(quests)
	item1.set_text(0, "Item 1")
	item2.set_text(0, "Item 2")
	var sub1 = $Tree.create_item(item1)
	sub1.set_text(0, "Sub item 1")
