extends Control

var selected = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#get_tree().reload_current_scene()
	PlayerStatus.meep = false
	PlayerStatus.oscar = false
	PlayerStatus.soup = false
	Globals.meep = false
	Globals.oscar = false
	Globals.soup = false
	# pass # Replace with function body.
	Dialogic.signal_event.connect(_on_dialogic_signal)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass

func _on_dialogic_signal(argument:String):
	#if argument == "new scene":
		#get_tree().change_scene_to_file("res://Scenes/WorldLevels/level_2.tscn")
	pass

func _on_oscar_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		selected += 1
		PlayerStatus.oscar = true
		Globals.oscar = true
		
	if !toggled_on:
		selected -= 1
		PlayerStatus.oscar = false
		Globals.oscar = false
	pass # Replace with function body.

func _on_meep_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		selected += 1
		PlayerStatus.meep = true
		Globals.meep = true
		
	if !toggled_on:
		selected -= 1
		PlayerStatus.meep = false
		Globals.meep = false
	pass # Replace with function body.

func _on_soup_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		selected += 1
		PlayerStatus.soup = true
		Globals.soup = true
		
	if !toggled_on:
		selected -= 1
		PlayerStatus.soup = false
		Globals.soup = false
	pass # Replace with function body.
	
func _on_confirm_characters_button_pressed() -> void:
	if selected > 2:
		Dialogic.start("res://Scenes/CharacterSelect/charSelect_OverUnder2.dtl")
	else:
		get_tree().change_scene_to_file("res://Scenes/WorldLevels/intro.tscn")
	pass # Replace with function body.
