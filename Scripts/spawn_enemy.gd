extends Node2D

class_name SpawnEnemy

var enemy : EnemyBase = null :
	set(val):
		enemy = val
		enemy.daddy = self
		enemy.dead()
		alive = false
var alive : bool = false :
	set(val):
		alive = val
		if not alive:
			$Timer.start()
var distance_max : float = 500
func _ready() -> void:
	enemy = get_node("Enemy")

func _on_timeout() -> void:
	enemy.global_position = global_position
	enemy.live()

func _physics_process(delta: float) -> void:
	if self.global_position.distance_to(enemy.global_position) > distance_max:
		enemy.global_position = self.global_position
