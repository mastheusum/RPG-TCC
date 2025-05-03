extends CanvasLayer

@export var knight : PackedScene
@export var ranger : PackedScene
@export var wizzard : PackedScene

@onready var player_pos = $"../PlayerSpawnPoint"

var pos : Vector2

func _ready() -> void:
	pos = player_pos.global_position

func _on_warrior_button_pressed() -> void:
	var player = knight.instantiate()
	player.global_position = pos
	player.name = "Player"
	get_parent().add_child(player)
	#get_parent().get_node("REFERENCIAL").visible = true
	visible = false

func _on_ranger_button_pressed() -> void:
	var player = ranger.instantiate()
	player.global_position = pos
	player.name = "Player"
	get_parent().add_child(player)
	get_parent().get_node("REFERENCIAL").visible = true
	visible = false

func _on_wizzard_button_pressed() -> void:
	var player = wizzard.instantiate()
	player.global_position = pos
	player.name = "Player"
	get_parent().add_child(player)
	get_parent().get_node("REFERENCIAL").visible = true
	visible = false
