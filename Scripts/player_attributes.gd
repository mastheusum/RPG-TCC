extends Node

var level : int 
var experience : int 
var exp_to_next_level : int 

var life_max : float
var life : float
var mana_max : float
var mana : float
var attack_base : float 
var attack_delta : float 

signal update_life(value : float)
signal update_max_life(value : float)
signal update_mana(value : float)
signal update_max_mana(value : float)
signal update_experience(value : float)
signal update_level(level : int, exp_current : float, exp_max : float)

func start_attr(life : float, mana : float, attack : float, delta : float):
	self.life_max = life
	self.life = life
	self.mana_max = mana
	self.mana = mana
	self.attack_base = attack
	self.attack_delta = delta
	emit_signal("update_max_life", self.life_max)
	emit_signal("update_life", self.life)
	emit_signal("update_max_mana", self.mana_max)
	emit_signal("update_mana", self.mana)
	emit_signal("update_experience", self.experience)
	emit_signal("update_level", self.level, self.experience, self.exp_to_next_level)

func gain_exp(amount):
	experience += amount
	if experience >= exp_to_next_level:
		level_up()
	
	emit_signal("update_experience", self.experience)

func level_up():
	level += 1
	experience -= exp_to_next_level
	exp_to_next_level = (2 * level) + 1
	
	emit_signal("update_level", self.level, self.experience, self.exp_to_next_level)
	emit_signal("update_max_life", self.life)

func take_damage(damage):
	life = clampf(life - damage, 0, life_max)
	emit_signal("update_life", self.life)

func death_punishment():
	experience *= 0.2
	emit_signal("update_experience", self.experience)
