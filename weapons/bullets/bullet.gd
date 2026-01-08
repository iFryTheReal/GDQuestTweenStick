extends Area2D

## Speed at which the bullet flies
@export var speed: float = 1000.0
## Maximum travel distance of the bullet
@export var max_range: float = 1500.0
var distance_traveled: float = 0.0

func _physics_process(delta: float) -> void:
	var direction: Vector2 = Vector2.RIGHT.rotated(rotation)
	var velocity: Vector2 = direction * speed
	position += velocity * delta
	
	distance_traveled += speed * delta

	if distance_traveled > max_range:
		_destroy()

func _destroy() -> void:
	queue_free()
