extends State
class_name EnemyActivation

@export var enemy: CharacterBody2D
@export var move_speed := 0

@export var completed := false

@onready var animation = $"../../AnimationPlayer"





func Enter():
	print("entered activation")
	animation.play("Activate")
	
func Update(delta: float):
	pass
		



func Physics_Update(delta: float):
	if completed == true:
		Transitioned.emit(self, "enemyidle")
