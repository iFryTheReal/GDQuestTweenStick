extends CenterContainer

@onready var _time: Label = %Time
@onready var _replay_button: Button = %ReplayButton
@onready var _quit_button: Button = %QuitButton

@export_group("Confettis", "confettis_")
@export var confettis_amount: int = 5
@export var confettis_spawn_delay: float = 0.5

var start_time: float = 0.0

func _ready() -> void:
	start_time = Time.get_ticks_msec()
	
	_replay_button.pressed.connect(func () -> void:
		get_tree().paused = false
		get_tree().reload_current_scene()
	)
	_quit_button.pressed.connect(get_tree().quit)
	
func make_visible() -> void:
	get_tree().paused = true
	set_elapsed_time()
	visible = true
	spawn_confettis()
	
func set_elapsed_time() -> void:
	var elapsed_time_ms: float = 0.0
	elapsed_time_ms = Time.get_ticks_msec() - start_time
	var elapsed_time_s: float = elapsed_time_ms / 1000
	elapsed_time_s = snappedf(elapsed_time_s, 0.01)
	_time.text = "Time : " + str(elapsed_time_s) + "s"

func spawn_confettis () -> void:
	var viewport_dimension: Vector2 = get_viewport_rect().size
	var confettis_scene: PackedScene = preload("uid://d25v1o0ynt2at")
	
	for _i in confettis_amount:
		await get_tree().create_timer(confettis_spawn_delay).timeout
		
		var confettis: GPUParticles2D = confettis_scene.instantiate()
		add_child(confettis)
		
		confettis.global_position = Vector2(randf_range(0.0, viewport_dimension.x), viewport_dimension.y)
		
		confettis.emitting = true
		
