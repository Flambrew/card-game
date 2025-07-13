# functional, will likely need updates

class_name Dash extends Card

func _init():
	id = 0
	mana_cost = 1
	title = "Dash"
	rarity = CardRarity.COMMON
	type = CardType.UTILITY
	sprite = load("res://assets/icon.svg")
	single_use = false
	single_opportunity = false

func action(source:Entity) -> void:
	var direction:Vector3 = Vector3(source.velocity.x, 0, source.velocity.z).normalized()
	direction.y = .25
	source.impulse(direction.normalized(), 10)
