extends CharacterBody2D

@onready var _detection_area: Area2D = %DetectionArea

var _player: Player = null

func _ready() -> void:
	_detection_area.body_entered.connect(func (body: Node) -> void:
		if body is Player:
			_player = body
			print_debug("Player entered at position : %.2v" % _player.position)
	)
	
	_detection_area.body_exited.connect(func (body: Node) -> void:
		if body is Player:
			print_debug("Player exited at position : %.2v" % _player.position)
			_player = null
	)

func _physics_process(delta: float) -> void:
	if _player != null:
		pass
