extends Control

var label_tween : Tween 
@onready var _label_damage : RichTextLabel = $LifeBar/Label_DamageTaken

func _ready() -> void:
	PlayerAttributes.connect("update_life", _update_lifebar)
	PlayerAttributes.connect("update_mana", _update_manabar)
	PlayerAttributes.connect("update_experience", _update_level)

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
