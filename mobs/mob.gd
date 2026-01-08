class_name Mob
extends CharacterBody2D

@onready var _detection_area: Area2D = %DetectionArea

## Maximum speed allowed for the mob
@export var max_speed: float = 600.0
## How much speed is added per seconds to the mob when it detect the player
@export var acceleration: float = 700.0
## How much speed is lost per seconds when the player release all movement keys
@export var deceleration: float = 700.0
## Mob health level
@export var health: int = 10 : set = set_health

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
	if _player == null:
		velocity = velocity.move_toward(Vector2.ZERO, deceleration * delta)
	else:
		var direction: Vector2 = global_position.direction_to(_player.global_position)
		var distance: float = global_position.distance_to(_player.global_position)
		var speed: float = max_speed if distance > 120.0 else max_speed * distance / 120.0
		var desired_velocity: Vector2 = direction * speed
		velocity = velocity.move_toward(desired_velocity, acceleration * delta)

	move_and_slide()	

func set_health(new_health: int) -> void:
	health = new_health
	if health <= 0:
		die()

func die() -> void:
	queue_free()
