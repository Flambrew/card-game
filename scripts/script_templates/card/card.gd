extends Card

func _init():
	id = -1
	mana_cost = 1
	title = "Placeholder"
	rarity = CardRarity.COMMON
	type = CardType.UTILITY
	sprite = load("res://game/assets/icon.svg")

func action(source:Entity) -> void:
	pass
