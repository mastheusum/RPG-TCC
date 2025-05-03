extends Resource

class_name Item

enum ItemRarity {
	COMMON, UNCOMMON,
	RARE, MYTHICAL,
	LEGENDARY
}

enum ItemType {
	HEAD, CHEST, LEGS,
	WEAPON, OFFHAND
}

const RarityColor = {
	ItemRarity.COMMON : Color.GRAY,
	ItemRarity.UNCOMMON : Color.GREEN,
	ItemRarity.RARE : Color.BLUE,
	ItemRarity.MYTHICAL : Color.RED,
	ItemRarity.LEGENDARY : Color.ORANGE
}

@export var identification : String
@export var rarity : ItemRarity
@export var sprite : Texture2D
@export var hability : SpellData
