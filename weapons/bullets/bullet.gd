extends Area2D

## Speed at which the bullet flies
@export var speed: float = 1000.0
## Maximum travel distance of the bullet
@export var max_range: float = 1500.0
## Damage done by the bullet
@export var damage: int = 2

@onready var _audio_stream_player_2d: AudioStreamPlayer2D = %AudioStreamPlayer2D

var distance_traveled: float = 0.0

func _ready() -> void:
	body_entered.connect(func (body: Node) -> void:
		if body is Mob:
			body = body as Mob
			body.take_damage(damage)
		_destroy()
	)

func _physics_process(delta: float) -> void:
	var direction: Vector2 = Vector2.RIGHT.rotated(rotation)
	var velocity: Vector2 = direction * speed
	position += velocity * delta
	
	distance_traveled += speed * delta

	if distance_traveled > max_range:
		_destroy()

func _destroy() -> void:
	_audio_stream_player_2d.play()
	set_physics_process(false)
	set_deferred("monitoring", false)
	visible = false
	_audio_stream_player_2d.finished.connect(queue_free)
