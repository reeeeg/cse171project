extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_restart_button_pressed() -> void:
	#var home = preload("res://Scenes/CharacterSelect/characterSelect.tscn")
	#get_tree().root.add_child(home)
	get_tree().change_scene_to_file("res://Scenes/Start/startScreen.tscn")
	#get_tree().reload_current_scene()
	pass # Replace with function body.
