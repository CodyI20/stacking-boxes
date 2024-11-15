extends Node

# MUSIC
@onready var background_music: AudioStreamPlayer = $BACKGROUND_MUSIC

# SFX - OBJECT RELEASE
@onready var release_sfx: AudioStreamPlayer = $SFX/STACKABLE_OBJECT_SFX/Release_SFX

# SFX - OPTIONS MENU FEEDBACK
@onready var sfx_feedback: AudioStreamPlayer = $SFX/OPTIONS_MENU/Sfx_feedback


func _ready() -> void:
	_event_subscription()
	if background_music.stream == null:
		printerr("THERE IS NO STREAM IN YOUR MUSIC! FIX IT! ~Also check the bus it's in while you're at it~")
		return
	background_music.play()
	
func _event_subscription() -> void:
	# SFX - OBJECT RELEASE
	Events.object_released.connect(play_object_released_sound)
	
	# SFX - OPTIONS MENU FEEDBACK
	Events.sfx_slider_value_set.connect(play_sfx_feedback_sound)
	
func play_object_released_sound(object: Node2D) -> void:
	release_sfx.play()
	
func play_sfx_feedback_sound() -> void:
	sfx_feedback.play()
