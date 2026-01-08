extends CharacterBody2D

@onready var _sprite_2d: Sprite2D = %Sprite2D

## Maximum speed allowed for the player character
@export var max_speed: float = 600.0
## How much speed is added per seconds to the player speed when a movement key is pressed
@export var acceleration: float = 1500.0
## How much speed is lost per seconds when the player release all movement keys
@export var deceleration: float = 1800.0

func _physics_process(delta: float) -> void:
	var direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var has_input_direction: bool = direction.length() > 0.0
	
	if has_input_direction:
		var desired_velocity: Vector2 = direction * max_speed
		velocity = velocity.move_toward(desired_velocity, acceleration * delta)
		_sprite_2d.rotate_sprite(direction)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, deceleration * delta)
		
	move_and_slide()
