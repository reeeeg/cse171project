extends Node2D

@onready var dash_timer = $Dashtimer



func start_dash(dash_duration):
	dash_timer.wait_time = dash_duration
	dash_timer.start()
	
func start_dashing():
	return !dash_timer.is_stopped()
