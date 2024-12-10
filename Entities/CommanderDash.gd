extends State

@export var enemy: CharacterBody2D
@export var move_speed := 600.0

var player : CharacterBody2D

signal CommanderDash

@onready var animation = $"../../AnimationPlayer"

func Enter():
	player = get_tree().get_first_node_in_group("Player")
	print("entered dash")
	player.dashing == true
	CommanderDash.emit()
	animation.play('dash')
	
func Physics_Update(delta: float):
	
	var direction = player.global_position - enemy.global_position
	player = get_tree().get_first_node_in_group("Player")
	enemy.velocity = direction.normalized() * move_speed
	
	if !player.dashing:
		var nowstate = get_parent().get_current_state()
		print(nowstate.State_Name)
		if nowstate.State_Name == 'death':
			return
		Transitioned.emit(self, 'idle') 


func _on_commander_boss_commander_death() -> void:
	print("follow death signal")
	Transitioned.emit(self, 'death') 
