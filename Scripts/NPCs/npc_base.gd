extends CharacterBody2D

@export var data : NPCTalkData

func _ready() -> void:
	$Area2D.connect("body_entered", _load_talks)
	$Area2D.connect("body_exited", _unload_talks)

func _load_talks(body : Node2D):
	if body.is_in_group("Player"):
		CanvasHud.get_node("NPC_talk").set_talks(data)

func _unload_talks(body : Node2D):
	if body.is_in_group("Player"):
		CanvasHud.get_node("NPC_talk").remove_talks()
