extends CharacterBody2D

class_name PlayerBase

@export var speed = 200
var physic_attack_bonus : int = 0
var physic_defense_bonus : int = 0
var magic_attack_bonus : int = 0
var move_speed_bonus : int = 0

static var main_character : PlayerBase = null

var direction := Vector2()

@onready var sprite : Sprite2D = $Sprite2D

func _ready() -> void:
	main_character = self
	CanvasHud.visible = true
	PlayerAttributes.start_attr(15, 5, 5, 5, 3)

func _physics_process(delta: float) -> void:
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction.normalized() * (speed + move_speed_bonus)
	move_and_slide()
	
	if velocity.x < 0:
		sprite.flip_h = true
	elif  velocity.x > 0:
		sprite.flip_h = false

func _process(delta: float) -> void:
	$AttackOffset.look_at( get_global_mouse_position() )

func take_damage(damage : float):
	var total_def = PlayerAttributes.physic_defense + physic_defense_bonus
	
	total_def += ManageInventory.get_defense()
	
	var dealty = damage - total_def
	PlayerAttributes.take_damage(dealty)
	
	if PlayerAttributes.life <= 0:
		get_tree().paused = true

func gain_exp(amount : float):
	PlayerAttributes.gain_exp(amount)

func healing(amount : float):
	PlayerAttributes.heal(amount)
