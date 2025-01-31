extends CharacterBody2D

class_name PlayerBase


@export var speed = 200
@export var power_min : int = 5
@export var power_max : int = 15

var life_max : float = 100.0
var life : float = 100.0
var mana_max : float = 100.0
var mana : float = 100.0

var direction := Vector2()
var label_tween : Tween 
@onready var _label_damage : RichTextLabel = $HUD/LifeBar/Label_DamageTaken

func _ready() -> void:
	_label_damage.visible = false
	$HUD/LifeBar.max_value = life_max
	$HUD/LifeBar.value = life

func _physics_process(delta: float) -> void:
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction.normalized() * speed
	move_and_slide()

func _process(delta: float) -> void:
	$AttackOffset.look_at( get_global_mouse_position() )

func take_damage(damage : float):
	life = clampf(life - damage, 0, life_max)
	$HUD/LifeBar.value = life
	taken_damage_intepolate(damage)
	if life <= 0:
		get_tree().paused = true

func taken_damage_intepolate(value):
	_label_damage.text = "[center]%.1f" % value
	_label_damage.visible = true
	label_tween = get_tree().create_tween()
	label_tween.tween_property(
		_label_damage,
		"position",
		_label_damage.position + Vector2(100, 0),
		1
	)
	label_tween.tween_callback(_reset_damage_label)

func _reset_damage_label():
	_label_damage.position = _label_damage.position - Vector2(100, 0)
	_label_damage.visible = false
	
