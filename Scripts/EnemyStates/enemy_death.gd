extends State

@export var enemy: CharacterBody2D
@export var move_speed := 10.0

@onready var animation = $"../../AnimationPlayer"





func Enter():
	enemy.velocity.x = 0
	enemy.velocity.y = 0
	animation.play('death')
	enemy.queue_free()
	

		
