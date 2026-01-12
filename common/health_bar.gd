extends Control

@onready var _progress_bar: ProgressBar = %ProgressBar

@export var max_health: int = 100 : set = set_max_health

@onready var fill_style: StyleBoxFlat = _progress_bar.get_theme_stylebox("fill", "ProgressBar")

var health_gradient: Gradient = Gradient.new()

func _ready() -> void:
	health_gradient.colors = PackedColorArray()
	health_gradient.add_point(0.0, Color(0.631, 0.0, 0.047, 1.0))
	health_gradient.add_point(0.5, Color(0.717, 0.464, 0.0, 1.0))
	health_gradient.add_point(1.0, Color(0.188, 0.545, 0.0))
	
func set_health(value: int) -> void:
	_progress_bar.value = value
	var health_percent: float = value / float(max_health)
	fill_style.bg_color = health_gradient.sample(health_percent)
	_progress_bar.theme.set_stylebox("fill", "ProgressBar", fill_style)

func set_max_health(value: int) -> void:
	max_health = value
	_progress_bar.max_value = max_health
