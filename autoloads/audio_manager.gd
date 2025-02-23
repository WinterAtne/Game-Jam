extends Node

const initial_streams : int = 8

var audio_streams : Array[AudioStreamPlayer] = []

func _ready() -> void:
	audio_streams.resize(initial_streams)
	for i in range(audio_streams.size()):
		audio_streams[i] = AudioStreamPlayer.new()
		add_child(audio_streams[i])
		

func play_sound(sound : AudioStream) -> void:
	assert(sound != null)
	var selected_stream : AudioStreamPlayer = null
	for i in range(audio_streams.size()):
		if audio_streams[i].stream == null:
			selected_stream = audio_streams[i]
			break
	
	if selected_stream == null:
		audio_streams.append(AudioStreamPlayer.new())
		selected_stream = audio_streams.back()
		add_child(audio_streams.back())
	
	selected_stream.stream = sound
	selected_stream.play()
	selected_stream.finished.connect(func() -> void: end_sound(selected_stream))
	

func end_sound(stream : AudioStreamPlayer) -> void:
	stream.stream = null

func end_all_sound() -> void:
	for s in audio_streams:
		s.stream = null

func _on_baseline_finished() -> void:
	%Baseline.play()
