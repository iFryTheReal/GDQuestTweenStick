extends Control

const HIGH_HEALTH: Color = Color(0.188, 0.545, 0.0)
const MID_HEALTH: Color = Color(0.717, 0.464, 0.0, 1.0)
const LOW_HEALTH: Color = Color(0.631, 0.0, 0.047, 1.0)

@onready var _progress_bar: ProgressBar = %ProgressBar

@export var max_health: int = 100 : set = set_max_health

@onready var fill_style: StyleBoxFlat = _progress_bar.get_theme_stylebox("fill", "ProgressBar")

func set_health(value: int) -> void:
	_progress_bar.value = value
	var health_percent: float = value / float(max_health)
	if health_percent < 0.3:
		fill_style.bg_color = LOW_HEALTH
	elif health_percent < 0.7 and health_percent >= 0.3:
		fill_style.bg_color = MID_HEALTH
	else:
		fill_style.bg_color = HIGH_HEALTH
	_progress_bar.theme.set_stylebox("fill", "ProgressBar", fill_style)

func set_max_health(value: int) -> void:
	max_health = value
	_progress_bar.max_value = max_health
