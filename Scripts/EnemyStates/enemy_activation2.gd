extends State
class_name EnemyActivation2

@export var enemy: CharacterBody2D
@export var move_speed := 0

@export var completed2 := false

@onready var animation = $"../../AnimationPlayer"





func Enter():
	print("entered activation")
	animation.play("Activate")
	



func Physics_Update(delta: float):
	print("completed")
	print(completed2)
	if completed2 == true:
		Transitioned.emit(self, "enemyidle")
