extends Control

var label_tween : Tween 
@onready var _label_damage : RichTextLabel = $LifeBar/Label_DamageTaken

func _ready() -> void:
	_label_damage.visible = false
	PlayerAttributes.connect("update_life", _update_lifebar)
	PlayerAttributes.connect("update_mana", _update_manabar)
	PlayerAttributes.connect("update_experience", _update_level)

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

func _update_lifebar(max_val : float, val : float):
	$LifeBar.max_value = max_val
	$LifeBar.value = val

func _update_manabar(max_val : float, val : float):
	$ManaBar.max_value = max_val
	$ManaBar.value = val

func _update_experience(val : float):
	$ExperienceBar.value = val

func _update_level(level, exp, exp_max):
	$Level.text = "[center] %d" % level
	$ExperienceBar.max_value = exp_max
	$ExperienceBar.value = exp
