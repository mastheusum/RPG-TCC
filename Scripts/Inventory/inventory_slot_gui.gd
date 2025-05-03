extends NinePatchRect

var _panel : Panel
var item : Item = null :
	set(val):
		item = val
		if item is Equipment:
			_panel = $EquipData
			val = item as Equipment
			_panel.get_node("VBox/Identification").text = "[center] %s" % val.identification
			_panel.get_node("VBox/Identification").modulate = item.RarityColor[item.rarity]
			_panel.get_node("VBox/Type").text = "Tipo: %s" % item.ItemType.keys()[val.type]
			_panel.get_node("VBox/Life").text = "Vida: +%d" % val.life
			_panel.get_node("VBox/Mana").text = "Mana: +%d" % val.mana
			_panel.get_node("VBox/Attack").text = "Ataque: +%d" % val.attack
			_panel.get_node("VBox/Defense").text = "Defesa: +%d" % val.defense

func _ready() -> void:
	if not _panel:
		_panel = $EquipData

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_action_pressed("right_mouse_action"):
			ManageInventory.equip_item(item)

func _on_mouse_entered() -> void:
	_panel.visible = true

func _on_mouse_exited() -> void:
	_panel.visible = false
