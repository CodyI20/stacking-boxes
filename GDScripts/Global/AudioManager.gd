extends Node

# Sound volume control variables
@export var master_volume: float = 1.0
@export var sfx_volume: float = 1.0
@export var music_volume: float = 1.0

var saved_master_volume_before_muting: float = 1.0

@export var current_music: AudioStreamPlayer = null
var sfx_players: Array = []

# Path to music and SFX variable
@export var default_music: AudioStream = null

func _ready() -> void:
	if default_music:
		play_music(default_music)
		
func event_subscription() -> void:
	Events.object_released.connect(play_sfx)
	pass

func play_music(music: AudioStream, loop: bool=true, crossfade_time: float = 0.0):
	if current_music:
		if crossfade_time > 0.0:
			current_music.fade_out(crossfade_time)
			await get_tree().create_timer(crossfade_time).timeout
		
		default_music.stop()
	
	current_music = AudioStreamPlayer.new()
	current_music.stream = music
	current_music.volume_db = linear2db(music_volume * master_volume)
	current_music.loop = loop
	add_child(current_music)
	current_music.play()
	
func stop_music() -> void:
	if current_music:
		current_music.stop()
		current_music.queue_free()

func play_sfx(sfx: AudioStream) -> void:
	var sfx_player = AudioStreamPlayer.new()
	sfx_player.stream = sfx
	sfx_player.volume_db = linear2db(sfx_volume * master_volume)
	sfx_player.autoplay = false
	add_child(sfx_player)
	sfx_player.play()
	
	# Remove SFX player when done playing
	sfx_player.connect("finished", queue_free)
	sfx_players.append(sfx_player)
	
func set_master_volume(volume: float) -> void:
	master_volume = clamp(volume, 0.0, 1.0)
	if current_music:
		current_music.volume_db = linear2db(music_volume * master_volume)
	for sfx_player in sfx_players:
		sfx_player.volume_db = linear2db(sfx_volume * master_volume)

func set_music_volume(volume: float) -> void:
	music_volume = clamp(volume, 0.0, 1.0)
	if current_music:
		current_music.volume_db = linear2db(music_volume * master_volume)
		
func set_sfx_volume(volume: float) -> void:
	sfx_volume = clamp(volume, 0.0, 1.0)
	for sfx_player in sfx_players:
		sfx_player.volume_db = linear2db(sfx_volume * master_volume)

# Utility function to transform to DB
func linear2db(linear: float) -> float:
	return 20.0 * log(max(linear, 0.0001)) / log(10.0)
	
func mute() -> void:
	saved_master_volume_before_muting = master_volume
	set_master_volume(0.0)

func unmute() -> void:
	set_master_volume(saved_master_volume_before_muting)
