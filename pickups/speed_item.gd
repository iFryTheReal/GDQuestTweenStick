class_name SpeedItem extends Item

@export var speed_amount: int = 0

func use(player: Player) -> void:
	player.apply_speed_boost(speed_amount, 5.0)
