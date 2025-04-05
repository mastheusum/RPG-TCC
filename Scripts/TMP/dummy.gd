extends CharacterBody2D

var life = 100

func take_damage(damage):
	if life <= 0:
		return
	print(damage)
	life -= damage
	if life <= 0:
		PlayerBase.main_character.gain_exp(3)
		dead()

func dead():
	$CollisionShape2D.disabled = true
	$AnimatedSprite2D.visible = false
	$Timer.start(3)

func _on_timer_timeout() -> void:
	life = 100
	$CollisionShape2D.disabled = false
	$AnimatedSprite2D.visible = true
