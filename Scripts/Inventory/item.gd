extends Resource

class_name Item

enum ItemRarity {
	COMMON, UNCOMMON,
	RARE, MYTHICAL,
	LEGENDARY
}

enum ItemType {
	HEAD, CHEST,
	ARMS, LEGS,
	WEAPON, OFFHAND
}

@export var identification : String
@export var rarity : ItemRarity
@export var sprite : Texture2D
