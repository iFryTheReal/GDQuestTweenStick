extends CenterContainer

@onready var _time: Label = %Time
@onready var _replay_button: Button = %ReplayButton
@onready var _quit_button: Button = %QuitButton

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
	
func set_elapsed_time() -> void:
	var elapsed_time_ms: float = 0.0
	elapsed_time_ms = Time.get_ticks_msec() - start_time
	var elapsed_time_s: float = elapsed_time_ms / 1000
	elapsed_time_s = snappedf(elapsed_time_s, 0.01)
	_time.text = "Time : " + str(elapsed_time_s) + "s"
