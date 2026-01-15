extends Area2D

signal player_entered

func _ready() -> void:
	body_entered.connect(func (body: Node) -> void :
		if body is Player:
			emit_signal("player_entered")
	)
