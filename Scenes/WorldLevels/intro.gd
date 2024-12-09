extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# pass # Replace with function body.
	Dialogic.signal_event.connect(_on_dialogic_signal)
	Dialogic.start("res://storyTimelines/1_gameStart.dtl")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_dialogic_signal(argument:String):
	if argument == "ready":
		print("lets goo")
	pass
