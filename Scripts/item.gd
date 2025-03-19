extends Resource

class_name Item
enum ItemRarity {
	COMMON, UNCOMMON,
	RARE, MYTHICAL,
	LEGENDARY
}
@export var identification : String
@export var rarity : ItemRarity
@export var sprite : Texture2D
