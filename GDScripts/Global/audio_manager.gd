extends Node

@onready var background_music: AudioStreamPlayer = $BACKGROUND_MUSIC
@onready var release_sfx: AudioStreamPlayer = $SFX/STACKABLE_OBJECT_SFX/Release_SFX


func _ready() -> void:
	_event_subscription()
	if background_music.stream == null:
		printerr("THERE IS NO STREAM IN YOUR MUSIC! FIX IT! ~Also check the bus it's in while you're at it~")
		return
	background_music.play()
	
func _event_subscription() -> void:
	Events.object_released.connect(play_object_released_sound)
	
func play_object_released_sound(object: Node2D) -> void:
	release_sfx.play()
