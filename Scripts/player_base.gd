extends CharacterBody2D

class_name PlayerBase

@export var speed = 200
@export var power_min : int = 5
@export var power_max : int = 15

@export_category("attributes")
@export var level : int = 1

var life_max : float = 100.0
var life : float = 100.0
var mana_max : float = 100.0
var mana : float = 100.0
var experience : int = 0
@export var exp_to_next_level : int = 0

var direction := Vector2()

@onready var sprite : Sprite2D = $Sprite2D

func _ready() -> void:
	$HUD/LifeBar.max_value = life_max
	$HUD/LifeBar.value = life
	
	$HUD/ExperienceBar.min_value = exp_to_next_level
	exp_to_next_level = 2 * level + 1
	$HUD/ExperienceBar.max_value = exp_to_next_level
	$HUD/ExperienceBar.value = experience
	
	$HUD/Level.text = "[center]1"

func _physics_process(delta: float) -> void:
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction.normalized() * speed
	move_and_slide()
	
	if velocity.x < 0:
		sprite.flip_h = true
	elif  velocity.x > 0:
		sprite.flip_h = false

func _process(delta: float) -> void:
	$AttackOffset.look_at( get_global_mouse_position() )

func take_damage(damage : float):
	life = clampf(life - damage, 0, life_max)
	$HUD/LifeBar.value = life
	$HUD.taken_damage_on_hud(damage)
	if life <= 0:
		get_tree().paused = true

func _level_up():
	level += 1
	$HUD/Level.text = "[center] %d " % level
	experience -= exp_to_next_level
	exp_to_next_level = (2 * level) + 1
	$HUD/ExperienceBar.max_value = exp_to_next_level

func gain_exp(amount):
	experience += amount
	if experience >= exp_to_next_level:
		_level_up()
	$HUD/ExperienceBar.value = experience
