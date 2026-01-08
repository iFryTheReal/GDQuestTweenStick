extends Node2D

## The bullet type instancied by the weapon
@export var bullet_scene: PackedScene = null
## Speed at which the bullet flies
@export_range(100.0, 5000.0, 10.0) var bullet_speed: float = 1500.0
## Maximum travel distance of the bullet
@export_range(100.0, 10000.0, 10.0) var bullet_range: float = 2000.0
## Maximum bullet spread, random angle a which the bullet spawn
@export_range(0.0, 360.0, 1.0, "radians_as_degrees") var max_bullet_spread: float = 0.0

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		shoot()


func shoot() -> void:
	var bullet: Area2D = bullet_scene.instantiate()
	get_tree().current_scene.add_child(bullet)
	
	bullet.global_position = global_position
	bullet.global_rotation = global_rotation
	bullet.speed = bullet_speed
	bullet.max_range = bullet_range
	bullet.rotation += randf_range(-max_bullet_spread / 2.0, max_bullet_spread /2.0)
