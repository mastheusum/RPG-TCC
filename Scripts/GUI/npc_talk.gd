extends Control

@export var data : NPCTalkData
var _index = -1
var _letters = 0

func _ready() -> void:
	self.visible = false
	$BG.visible = false
	
	$Interact.visible = false
	$Interact.disabled = true
	
	$Next.visible = false
	$Next.disabled = true
	
	$Options.visible = false
	$Options/Accept.disabled = true
	$Options/Negate.disabled = true
	
	$Interact.connect("pressed", start_talk)
	$Next.connect("pressed", advance_talk)
	$Options/Accept.connect('pressed', accept_talk)
	$Options/Negate.connect('pressed', negate_talk)
	$Delay.connect("timeout", _timed)

func set_talks(data : NPCTalkData):
	self.data = data
	self.visible = true
	$Interact.disabled = false
	$Interact.visible = true

func remove_talks():
	self.visible = false
	$BG.visible = false
	self.data = null
	_index = -1
	$Delay.stop()
	$BG/Label.text = ""
	$Interact.disabled = true

func start_talk():
	_index = 0
	_letters = 0
	if _index >= data.talks.size():
		remove_talks()
		return
	$Interact.visible = false
	$Interact.disabled = true
	
	_active_buttons()
	
	$BG.visible = true
	$BG/Label.visible_characters = _letters
	$BG/Label.text = data.talks[_index]
	
	$Delay.start(0.05)
	# $Interact.disabled = _index >= data.talks.size()

func advance_talk():
	if _letters >= data.talks[_index].length():
		_index += 1
		_letters = 0
		if _index >= data.talks.size():
			remove_talks()
			return
		_active_buttons()
		$BG/Label.visible_characters = _letters
		$BG/Label.text = data.talks[_index]
		$Delay.start(0.05)
	else:
		_letters = data.talks[_index].length()

func accept_talk():
	pass

func negate_talk():
	pass

func _timed():
	_letters += 1
	$BG/Label.visible_characters = _letters
	if _letters < data.talks[_index].length():
		$Delay.start(0.05)
	

func _active_buttons():
	$Next.visible = false
	$Next.disabled = true
	
	$Options.visible = false
	$Options/Accept.disabled = true
	$Options/Negate.disabled = true
	
	match data.opt[_index]:
		data.Options.NEXT:
			$Next.visible = true
			$Next.disabled = false
		data.Options.ACCEPT:
			$Options.visible = true
			$Options/Accept.disabled = false
			$Options/Negate.disabled = false
		
