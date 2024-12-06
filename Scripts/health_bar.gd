extends TextureProgressBar

@export var character: CharacterBody2D

#@export var health: Health = character.get_node("Health")
@onready var health: Health = character.find_children("*", "Health")[0]

func _ready() -> void:
	max_value = health.max_health
	value = health.health
	health.health_changed.connect(_update_bar)
	
	
func _update_bar(_diff: int) -> void:
	value = health.get_health()
