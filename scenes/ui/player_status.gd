extends CanvasLayer

const display_jamed_time : float = 0.2

var jam_count : int = 0

func set_health(new_health : int) -> void:
	%HealthBar.value = new_health

func display_jam() -> void:
	if %Jam.visible:
		pass
	
	jam_count += 1
	%JamCounter.text = str(jam_count)
	
	%Jam.visible = true
	get_tree().create_timer(display_jamed_time).timeout.connect(
		(func(): %Jam.visible = false),
		CONNECT_DEFERRED
		)
	

func _on_visibility_changed() -> void:
	jam_count = 0
