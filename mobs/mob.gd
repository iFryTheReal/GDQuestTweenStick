class_name Mob
extends CharacterBody2D

@onready var _detection_area: Area2D = %DetectionArea
@onready var _hit_box: Area2D = $HitBox
@onready var _health_bar: Control = %HealthBar
@onready var _damage_timer: Timer = %DamageTimer
@onready var _animation_player: AnimationPlayer = %AnimationPlayer

## Maximum speed allowed for the mob
@export var max_speed: float = 600.0
## How much speed is added per seconds to the mob when it detect the player
@export var acceleration: float = 700.0
## How much speed is lost per seconds when the player release all movement keys
@export var deceleration: float = 700.0
## Mob health level
@export var health: int = 10 : set = set_health
## Mob maximum health
@export_range(1, 100, 1, "or_greater") var max_health: int = 20
## Damage inflicted by the mob
@export var damage: int = 1

var _player: Player = null

func _ready() -> void:
	_health_bar.max_health = max_health
	health = max_health
	
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

	_hit_box.body_entered.connect(func (body: Node) -> void:
		if body is Player and _damage_timer.is_stopped():
			_player.take_damage(damage)
			_damage_timer.start()
	)
	
	_hit_box.body_exited.connect(func (body: Node) -> void:
		if body is Player:
			_damage_timer.stop()
	)
	
	_damage_timer.timeout.connect(func () -> void:
			_player.take_damage(damage)
			_damage_timer.start()
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
	_health_bar.set_health(health)
	if health <= 0:
		die()

func take_damage(damage: int) -> void:
	health -= damage
	
	modulate = Color.RED
	var tween: Tween = create_tween()
	tween.tween_property(self, "modulate", Color.WHITE, 0.1)

func die() -> void:
	set_physics_process(false)
	_animation_player.play("death_animation")
	_animation_player.animation_finished.connect(func (animation_name: String) -> void:
		if animation_name == "death_animation":
			queue_free()
	)
