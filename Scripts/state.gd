extends Node
class_name State

signal Transitioned

@export var State_Name : String

func Enter():
	pass
	
func Exit():
	pass

func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
	pass


func _on_boss_1_death() -> void:
	pass # Replace with function body.


func _on_boss_1_attackedfin() -> void:
	pass # Replace with function body.
