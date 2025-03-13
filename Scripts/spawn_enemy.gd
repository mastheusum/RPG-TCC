extends Node2D

class_name SpawnEnemy

var enemy : EnemyBase
var alive : bool = false :
	set(val):
		alive = val
		if not alive:
			$Timer.start()

func _ready() -> void:
	enemy = get_node("EnemyBase")
	enemy.daddy = self
	enemy.dead()
	alive = false

func _on_timeout() -> void:
	enemy.global_position = global_position
	enemy.live()
