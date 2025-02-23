extends CanvasLayer


func _on_sound_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0, value)
	if value == %SoundSlider.min_value:
		AudioServer.set_bus_mute(0, true)
	else:
		AudioServer.set_bus_mute(0, false)
