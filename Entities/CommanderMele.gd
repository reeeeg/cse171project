extends State

@export var enemy: CharacterBody2D

var player : CharacterBody2D

@onready var animation = $"../../CommanderAnimation"

func Enter():
	print("entered mele")
	enemy.velocity.x = 0
	animation.play("atk")



func _on_commander_boss_commander_death() -> void:
	print("mele death signal")
	Transitioned.emit(self, 'death') 


func _on_commander_boss_commander_mele() -> void:
	var nowstate = get_parent().get_current_state()
	print(nowstate.State_Name)
	if nowstate.State_Name == 'death':
		return
	Transitioned.emit(self, 'idle')
