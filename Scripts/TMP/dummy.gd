extends CharacterBody2D

var life = 100
var vitms : Array[Node2D] = []

func _ready() -> void:
	check_angry()

func _process(delta: float) -> void:
	if $ProgressBar.visible:
		$ProgressBar.value = 2 - $TimerAttack.time_left

func check_angry():
	if "angry" in self.name:
		$ProgressBar.max_value = 2
		$ProgressBar.visible = true
		$TimerAttack.wait_time = 2
		$TimerAttack.autostart = true
		$TimerAttack.start()
	else:
		$ProgressBar.visible = false

func take_damage(damage):
	if life <= 0:
		return
	print(name, '->' ,damage)
	life -= damage
	if life <= 0:
		PlayerBase.main_character.gain_exp(3)
		dead()

func dead():
	$CollisionShape2D.disabled = true
	$AnimatedSprite2D.visible = false
	$TimerRespawn.start(3)
	$TimerAttack.stop()
	$ProgressBar.visible = false
	

func _on_timer_timeout() -> void:
	life = 100
	$CollisionShape2D.disabled = false
	$AnimatedSprite2D.visible = true
	check_angry()

func attack():
	for vitm in vitms:
		vitm.take_damage(10)

func _on_timer_attack_timeout() -> void:
	attack()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		vitms.append(body)

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body in vitms:
		vitms.erase(body)
