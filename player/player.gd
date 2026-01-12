class_name Player
extends CharacterBody2D

@onready var _body_sprite: Sprite2D = %BodySprite
@onready var _collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var _health_bar: Control = %HealthBar
@onready var _weapon: Node2D = %Weapon
@onready var _weapon_pivot: Node2D = %WeaponPivot
@onready var _animation_player: AnimationPlayer = $AnimationPlayer

## Maximum speed allowed for the player character
@export var max_speed: float = 600.0
## How much speed is added per seconds to the player speed when a movement key is pressed
@export var acceleration: float = 1500.0
## How much speed is lost per seconds when the player release all movement keys
@export var deceleration: float = 1800.0
## Maximum health of the player character
@export_range(1, 100, 1, "or_greater") var max_health: int = 20

var health: int = 0 : set = set_health

func _ready() -> void:
	_health_bar.max_health = max_health
	health = max_health

func _physics_process(delta: float) -> void:
	var direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var has_input_direction: bool = direction.length() > 0.0
	
	if has_input_direction:
		var desired_velocity: Vector2 = direction * max_speed
		velocity = velocity.move_toward(desired_velocity, acceleration * delta)
		_body_sprite.rotate_sprite(direction)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, deceleration * delta)
		
	move_and_slide()

func set_health(new_health: int) -> void:
	health = clampi(new_health, 0, max_health)
	_health_bar.set_health(health)
	if health == 0:
		die()
		
func take_damage(damage: int) -> void:
	health -= damage
	
	_body_sprite.modulate = Color.RED
	var tween: Tween = create_tween()
	tween.tween_property(_body_sprite, "modulate", Color.WHITE, 0.1)

func die() -> void:
	toggle_player_control(false)
	_collision_shape_2d.set_deferred("disabled", true)
	_animation_player.play("death_animation")
	_animation_player.animation_finished.connect(func (animation_name: String) -> void:
		if animation_name == "death_animation":
			queue_free()
	)

func toggle_player_control(is_active: bool) -> void:
	set_physics_process(is_active)
	_weapon.set_physics_process(is_active)
	_weapon_pivot.set_process(is_active)
