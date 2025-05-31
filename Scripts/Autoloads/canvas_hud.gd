extends CanvasLayer

func _process(delta: float) -> void:
	if not PlayerBase.main_character:
		return
	elif not $HUD_bars.visible:
		$HUD_bars.visible= true
		$hud_skills.visible = true
		
