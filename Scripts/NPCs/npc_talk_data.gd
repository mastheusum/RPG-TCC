extends Resource

class_name NPCTalkData

enum Options {
	NEXT, BYE, ACCEPT
}
@export_multiline var talks : Array[String]
@export var opt : Array[Options]
