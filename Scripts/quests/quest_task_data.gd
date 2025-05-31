extends Resource

class_name QuestTaskData

enum Type {
	COLLECT, KILL, TALK
}

@export var quest_name : String
@export var type : Type
@export var target_identification : String
# o atributo acima é utilizado para identificar o NPC, Item ou MOB
# que se deve interagir/usar/matar para concluir a quest
@export var amount : int
@export var exp_bount : int
@export var gold_bount : int
@export var itens_bount : Array[Item]

func check(identification : String, amount : int) -> bool:
	if identification != self.identification:
		return false
	
	self.amount -= amount
	return self.amount == 0
