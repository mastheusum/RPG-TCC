extends Control

var label_tween : Tween 
@onready var _label_damage : RichTextLabel = $LifeBar/Label_DamageTaken

func _ready() -> void:
	_label_damage.visible = false


func taken_damage_on_hud(value):
	_label_damage.text = "[center]%.1f" % value
	taken_damage_intepolate()

func taken_damage_intepolate():
	_label_damage.visible = true
	label_tween = get_tree().create_tween()
	label_tween.tween_property(
		_label_damage,
		"position",
		_label_damage.position - Vector2(0, 24),
		1
	)
	label_tween.tween_callback(_reset_damage_label)

func _reset_damage_label():
	_label_damage.position = _label_damage.position + Vector2(0, 24)
	_label_damage.visible = false
