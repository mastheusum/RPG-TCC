extends BaseSpell

@export var duration : float = 5
@export var delay : float = 1
var power : float = 0
var targets = []

func _on_ready():
	$End.connect("timeout", _on_timeout)
	$Active.connect("timeout", _on_activate)
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)
	
	$End.wait_time = duration
	$End.autostart = true
	
	$Active.wait_time = delay
	$Active.autostart = true
	
	$End.start()
	$Active.start()

func _on_body_entered(body : Node2D):
	if body.is_in_group("Enemy"):
		targets.append(body)

func _on_body_exited(body : Node2D):
	if body in targets:
		targets.erase( body )

func _on_timeout():
	queue_free()

func _on_activate():
	for entity in targets:
		entity = entity
		entity.take_damage(power)
