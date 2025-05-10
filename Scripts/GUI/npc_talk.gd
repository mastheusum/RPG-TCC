extends Control

@export var data : NPCTalkData
var _index = -1
var _letters = 0

func _ready() -> void:
	$Interact.connect("pressed", start_talk)
	$Delay.connect("timeout", _timed)

func set_talks(data : NPCTalkData):
	self.data = data
	visible = true
	$Interact.disabled = false

func remove_talks():
	visible = false
	$BG.visible = false
	self.data = null
	_index = -1
	$Delay.stop()
	$BG/Label.text = ""
	$Interact.disabled = true

func start_talk():
	_index += 1
	_letters = 0
	if _index >= data.talks.size():
		remove_talks()
		return
	$BG.visible = true
	$BG/Label.visible_characters = _letters
	$BG/Label.text = data.talks[_index]
	$Delay.start(0.05)
	$Interact.disabled = _index >= data.talks.size()

func _timed():
	_letters += 1
	$BG/Label.visible_characters = _letters
	if _letters < data.talks[_index].length():
		$Delay.start(0.05)
	
