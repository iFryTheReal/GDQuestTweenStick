@tool
extends Area2D

@export var possible_items: Array[Item] = []

var _player: Player = null

func _ready() -> void:
	if not Engine.is_editor_hint():
		body_entered.connect(func (body: Node) -> void:
			if body is Player:
				_player = body
		)
		
		body_exited.connect(func (body: Node) -> void:
			if body is Player:
				_player = null
		)
	
func _unhandled_input(event: InputEvent) -> void:
	if not Engine.is_editor_hint():
		if event.is_action_pressed("interact") and _player != null:
			open()

func open() -> void:
	pass

func _get_configuration_warnings() -> PackedStringArray:
	return ["\"possible_items\" array is empty"] if possible_items.is_empty() else [""]
