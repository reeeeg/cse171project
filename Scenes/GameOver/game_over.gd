extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	
	# restart button pressed, reset game

	get_tree().change_scene("res://Scenes/CharacterSelect.tscn")
	get_tree().reload_current_scene()

	pass # Replace with function body.