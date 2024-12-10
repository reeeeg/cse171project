extends State

@export var enemy: CharacterBody2D

@onready var animation = $"../../CommanderAnimation"

func Enter():
	enemy.velocity.x = 0
	enemy.velocity.y = 0
	animation.play('death')
	enemy.queue_free()
