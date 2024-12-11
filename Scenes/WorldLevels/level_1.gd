extends Node2D

#var dead = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# pass # Replace with function body.
	Dialogic.signal_event.connect(_on_dialogic_signal)
	
	Dialogic.start("res://storyTimelines/3_outskirts.dtl")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if dead == false:
		#checkDead()
	pass

func _on_dialogic_signal(argument:String):
	if argument == "nextBoss2":
		get_tree().change_scene_to_file("res://Scenes/WorldLevels/level_2.tscn")
#
#func checkDead():
	#var delay = 3.0
	#if !PlayerStatus.alive:
		#dead = true
		#Dialogic.start("res://Scenes/GameOver/introDeath.dtl")
		#await get_tree().create_timer(delay).timeout
		#get_tree().reload_current_scene()
		#dead = false
