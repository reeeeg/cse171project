extends Node2D

var dead = false
var slimeDead = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# pass # Replace with function body.
	Dialogic.signal_event.connect(_on_dialogic_signal)
	
	Dialogic.start("res://storyTimelines/1_gameStart.dtl")
	PlayerStatus.alive = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if dead == false:
		checkDead()
	if slimeDead == false:
		checkSlimeDead()

func _on_dialogic_signal(argument:String):
	if argument == "new scene":
		get_tree().change_scene_to_file("res://Scenes/WorldLevels/level_2.tscn")

func checkDead():
	var delay = 3.0
	if !PlayerStatus.alive:
		dead = true
		Dialogic.start("res://Scenes/GameOver/introDeath.dtl")
		await get_tree().create_timer(delay).timeout
		get_tree().reload_current_scene()
		dead = false

func checkSlimeDead():
	if !PlayerStatus.introSlimeAlive:
		slimeDead = true
		Dialogic.start("res://storyTimelines/3_busStop.dtl")

func isSlimeDead() -> bool:
	return PlayerStatus.introSlimeAlive
