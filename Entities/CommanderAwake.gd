extends State
class_name CommanderAwake

@export var enemy: CharacterBody2D
@export var move_speed := 0

@export var awake := false
@onready var animation = $"../../AnimationPlayer"

func Enter():
	print("entered activation")
	animation.play("awake")
	



func Physics_Update(delta: float):
	print("completed")
	print(awake)
	if awake:
		Transitioned.emit(self, "idle")
