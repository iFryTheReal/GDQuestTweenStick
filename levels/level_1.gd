extends Node2D

@onready var end_menu: CenterContainer = $EndMenu
@onready var _teleporter: Area2D = $Teleporter

func _ready() -> void:
	_teleporter.player_entered.connect(end_menu.make_visible)
