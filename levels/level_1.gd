extends Node2D

@onready var _teleporter: Area2D = $RoomC/Teleporter
@onready var _end_menu: CenterContainer = $CanvasLayer/EndMenu

func _ready() -> void:
	_teleporter.player_entered.connect(_end_menu.make_visible)
