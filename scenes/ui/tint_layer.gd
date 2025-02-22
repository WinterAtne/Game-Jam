class_name TintLayer
extends CanvasLayer

var current_color : Color = Color.TRANSPARENT
var desired_color : Color = Color.TRANSPARENT
var transition_weight : float = 0.0

func _physics_process(delta: float) -> void:
	current_color = current_color.lerp(desired_color, transition_weight)
	%ColorRect.color = current_color

func change_color(color : Color, new_weight : float = 0) -> void:
	desired_color = color
	if new_weight > 0.0:
		transition_weight = new_weight
	else:
		current_color = desired_color
		transition_weight = 0
