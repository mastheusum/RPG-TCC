extends BaseSpell

class_name BuffSpell

@export var duration : float = 5
@export var move_speed : float = 0
@export var physic_attack : float = 0
@export var physic_defense : float = 0
@export var magic_attack : float = 0
var target

func _on_ready():
	$CollisionShape2D.disabled = true
	$End.connect("timeout", _on_timeout)
	
	$End.wait_time = duration
	$End.autostart = true
	
	target = PlayerBase.main_character
	
	target.move_speed_bonus += move_speed
	target.physic_attack_bonus += physic_attack
	target.physic_defense_bonus += physic_defense
	target.magic_attack_bonus += magic_attack
	
	$End.start()

func _on_timeout():
	target.move_speed_bonus -= move_speed
	target.physic_attack_bonus -= physic_attack
	target.physic_defense_bonus -= physic_defense
	target.magic_attack_bonus -= magic_attack
	queue_free()
