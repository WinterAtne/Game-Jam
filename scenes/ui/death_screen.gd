extends CanvasLayer

func set_death_count(count : int) -> void:
	print(count)
	%JamCount.text = "Jams: " + str(count)
