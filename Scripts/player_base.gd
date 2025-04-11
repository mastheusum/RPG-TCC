extends CharacterBody2D

class_name PlayerBase

@export var speed = 200

static var main_character : PlayerBase = null

var direction := Vector2()

@onready var sprite : Sprite2D = $Sprite2D

func _ready() -> void:
	main_character = self
	
	PlayerAttributes.connect("update_life", update_life_bar)
	
	PlayerAttributes.connect("update_mana", update_mana_bar)
	
	PlayerAttributes.connect("update_level", update_level)
	PlayerAttributes.connect("update_experience", update_experience)
	
	PlayerAttributes.start_attr(15, 5, 5, 5, 3)

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
	var total_def = PlayerAttributes.physic_defense
	
	if ManageInventory.head.item:
		total_def += (ManageInventory.head.item as Equipment).defense
	if ManageInventory.chest.item:
		total_def += (ManageInventory.chest.item as Equipment).defense
	if ManageInventory.legs.item:
		total_def += (ManageInventory.legs.item as Equipment).defense
	if ManageInventory.weapon.item:
		total_def += (ManageInventory.weapon.item as Equipment).defense
	if ManageInventory.offhand.item:
		total_def += (ManageInventory.offhand.item as Equipment).defense
	
	var dealty = damage - total_def
	PlayerAttributes.take_damage(dealty)
	
	$HUD/LifeBar.value = PlayerAttributes.life
	$HUD.taken_damage_on_hud(dealty)
	
	if PlayerAttributes.life <= 0:
		get_tree().paused = true

func gain_exp(amount : float):
	PlayerAttributes.gain_exp(amount)

func update_life_bar(current : float, limit : float):
	$HUD/LifeBar.max_value = limit
	$HUD/LifeBar.value = current

func update_mana_bar(current : float, limit : float):
	$HUD/ManaBar.max_value = limit
	$HUD/ManaBar.value = current

func update_experience(val : float):
	$HUD/ExperienceBar.value = val

func update_level(level, exp, exp_max):
	$HUD/Level.text = "[center] %d" % PlayerAttributes.level
	$HUD/ExperienceBar.max_value = PlayerAttributes.exp_to_next_level
	$HUD/ExperienceBar.value = PlayerAttributes.experience
