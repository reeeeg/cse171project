extends State

@export var enemy: CharacterBody2D

var player : CharacterBody2D

@onready var animation = $"../../AnimationPlayer"



func Enter():
	print("entered mele")
	enemy.velocity.x = 0
	animation.play("atk2")
	
func _on_boss_1_death() -> void:
	print("mele death signal")
	Transitioned.emit(self, 'death') 


func _on_boss_1_attackedfin() -> void:
	var nowstate = get_parent().get_current_state()
	print(nowstate.State_Name)
	if nowstate.State_Name == 'death':
		return
	Transitioned.emit(self, 'enemyidle') # Replace with function body.


func _on_boss_2_attackedfin() -> void:
	var nowstate = get_parent().get_current_state()
	print(nowstate.State_Name)
	if nowstate.State_Name == 'death':
		return
	Transitioned.emit(self, 'enemyidle') # Replace with function body.


func _on_boss_2_death() -> void:
	print("mele death signal")
	Transitioned.emit(self, 'death')  # Replace with function body.
