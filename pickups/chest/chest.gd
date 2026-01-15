@tool
extends Area2D

@onready var _animation_player: AnimationPlayer = %AnimationPlayer

@export var possible_items: Array[Item] = []
@export var min_spawn_distance: float = 20.0
@export var max_spawn_distance: float = 100.0

var _player: Player = null
var pickup_scene: PackedScene = preload("uid://di05o5yap3qja")

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
	set_process_unhandled_input(false)
	_animation_player.play("opening")
	var pickup_item: Pickup = pickup_scene.instantiate()
	pickup_item.item = possible_items.pick_random()
	var spawn_angle: float = randf_range(0.0, 2 * PI)
	var spawn_distance: float = randf_range(min_spawn_distance, max_spawn_distance)
	var land_position: Vector2 = Vector2.RIGHT.rotated(spawn_angle) * spawn_distance
	add_child(pickup_item)
	
	const FLIGHT_TIME := 0.4
	const HALF_FLIGHT_TIME := FLIGHT_TIME / 2.0
	
	var tween := create_tween()
	tween.set_parallel()
	pickup_item.scale = Vector2(0.25, 0.25)
	tween.tween_property(pickup_item, "scale", Vector2(1.0, 1.0), HALF_FLIGHT_TIME)
	tween.tween_property(pickup_item, "position:x", land_position.x, FLIGHT_TIME)

	tween = create_tween()
	tween.set_trans(Tween.TRANS_QUAD)
	tween.set_ease(Tween.EASE_OUT)
	var jump_height := randf_range(30.0, 80.0)
	tween.tween_property(pickup_item, "position:y", land_position.y - jump_height, HALF_FLIGHT_TIME)
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(pickup_item, "position:y", land_position.y, HALF_FLIGHT_TIME)

func _get_configuration_warnings() -> PackedStringArray:
	return ["\"possible_items\" array is empty"] if possible_items.is_empty() else []
