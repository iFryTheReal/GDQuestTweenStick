@tool
class_name Pickup extends Area2D

@onready var _sprite_2d: Sprite2D = %Sprite2D
@onready var _audio_stream_player: AudioStreamPlayer2D = %AudioStreamPlayer

@export var item: Item = null : set = set_item

func _ready() -> void:
	set_item(item)
	
	body_entered.connect(func (body: Node) -> void:
		if body is Player:
			set_deferred("monitoring", false)
			_sprite_2d.visible = false
			item.use(body)
			_audio_stream_player.play()
			_audio_stream_player.finished.connect(queue_free)
	)

func set_item(new_item: Item) -> void:
	item = new_item
	if _sprite_2d != null:
		_sprite_2d.texture = item.item_sprite
	if _audio_stream_player != null:
		_audio_stream_player.stream = item.pickup_sound
