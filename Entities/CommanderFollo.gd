extends State

@export var enemy: CharacterBody2D
@export var move_speed := 150.0

var player : CharacterBody2D

func Enter():
	print("entered follow")
	player = get_tree().get_first_node_in_group("Player")
	

func Physics_Update(delta: float):
	var direction = player.global_position - enemy.global_position
	
	if direction.length() > 250:
		enemy.velocity = direction.normalized() * move_speed
	else:
		player = get_tree().get_first_node_in_group("Player")
		direction = player.global_position - enemy.global_position
		
		if direction.x < 0.0:
			enemy.velocity.x = 0.1
		else:
			enemy.velocity.x = -.01
		Transitioned.emit(self, "mele")
		


func _on_commander_boss_commander_death() -> void:
	print("follow death signal")
	Transitioned.emit(self, 'death') 
