extends CanvasLayer

const display_jamed_time : float = 0.2

func set_health(new_health : int) -> void:
	%HealthBar.value = new_health

func display_jam() -> void:
	if %Jam.visible:
		pass
	
	%Jam.visible = true
	get_tree().create_timer(display_jamed_time).timeout.connect(
		(func(): %Jam.visible = false),
		CONNECT_DEFERRED
		)
	
