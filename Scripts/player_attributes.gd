extends Node

var level : int 
var experience : int 
var exp_to_next_level : int 

var life_max : float
var life : float
var mana_max : float
var mana : float

var physic_power : float 
var physic_power_delta : float 
var magic_power : float 
var magic_power_delta : float 

signal update_life(max_value : float, value : float)
signal update_mana(max_value : float, value : float)
signal update_experience(value : float)
signal update_level(level : int, exp_current : float, exp_max : float)

func start_attr(physic_power : float, physic_delta : float, magic_power : float, magic_delta : float):
	self.level = 1
	experience = 0
	exp_to_next_level = (2 * level) + 1
	
	define_max_life()
	define_max_mana()
	
	self.life = self.life_max
	self.mana = self.mana_max
	
	self.physic_power = physic_power
	self.physic_power_delta = physic_delta
	self.magic_power = magic_power
	self.magic_power_delta = magic_delta
	
	emit_signal("update_life", self.life_max, self.life)
	emit_signal("update_mana", self.mana_max, self.mana)
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
	
	# utilizadas para saber a porcentagem da vida e mana atual
	# essa porcentagem deve ser mantida ao subir de nível
	var mana_perc = mana / mana_max
	var life_perc = life / life_max
	
	define_max_life()
	define_max_mana()
	
	emit_signal("update_level", self.level, self.experience, self.exp_to_next_level)
	emit_signal("update_life", self.life_max, self.life_max * life_perc)
	emit_signal("update_mana", self.mana_max, self.mana_max * mana_perc)

func take_damage(damage):
	life = clampf(life - damage, 0, life_max)
	emit_signal("update_life", self.life)

func death_punishment():
	experience *= 0.2
	emit_signal("update_experience", self.experience)

func define_max_life():
	life_max = level * 20

func define_max_mana():
	mana_max = level * 10
