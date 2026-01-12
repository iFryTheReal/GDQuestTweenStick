class_name HealingItem extends Item

@export var healing_amount: int = 0

func use(player: Player) -> void:
	player.health += healing_amount
