extends Sprite2D

const GODOT_UP = preload("uid://b2q8n8kfhhbi7")
const GODOT_UP_RIGHT = preload("uid://deiak2vt25cwr")
const GODOT_RIGHT = preload("uid://dscj1kv8s4bxa")
const GODOT_BOTTOM_RIGHT = preload("uid://cm33qabjyo48g")
const GODOT_BOTTOM = preload("uid://bw03btxpkxde4")

const UP_RIGHT = Vector2.UP + Vector2.RIGHT
const DOWN_RIGHT = Vector2.DOWN + Vector2.RIGHT
const DOWN_LEFT = Vector2.DOWN + Vector2.LEFT
const UP_LEFT = Vector2.UP + Vector2.LEFT

func rotate_sprite(direction: Vector2) -> void:
	var sprite_direction = direction.sign()
	
	# Flip the sprite horizontaly to match it with movement on the left
	# (there isn't left looking sprite provided, so we flip le right looking ones)
	flip_h = sprite_direction.x < 0.0
	
	match sprite_direction:
		Vector2.UP:
			texture = GODOT_UP
		UP_RIGHT, UP_LEFT:
			texture = GODOT_UP_RIGHT
		Vector2.RIGHT, Vector2.LEFT:
			texture = GODOT_RIGHT
		DOWN_RIGHT, DOWN_LEFT:
			texture = GODOT_BOTTOM_RIGHT
		Vector2.DOWN:
			texture = GODOT_BOTTOM
