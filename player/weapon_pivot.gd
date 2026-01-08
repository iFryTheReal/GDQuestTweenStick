extends Node2D

var is_using_gamepad: bool = false

func _process(delta: float) -> void:
	var aim_direction: Vector2 = Vector2.ZERO
	if is_using_gamepad:
		aim_direction = Input.get_vector("aim_left", "aim_right", "aim_up", "aim_down")
	else:
		aim_direction = global_position.direction_to(get_global_mouse_position())

	if aim_direction.length() > 0.0:
		rotation = aim_direction.angle()
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion or event is InputEventKey:
		is_using_gamepad = false
	elif event is InputEventJoypadMotion or event is InputEventJoypadButton:
		is_using_gamepad = true
