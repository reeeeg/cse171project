extends State
class_name CommanderDashing

@export var enemy: CharacterBody2D
@export var move_speed := 450.0
@export var start :=false

var player : CharacterBody2D

signal CommanderDash

@onready var animation = $"../../CommanderAnimation"
var direction
func Enter():
	player = get_tree().get_first_node_in_group("Player")
	direction = player.global_position - enemy.global_position
	enemy.velocity.x = 0
	start = false
	print("entered dash")
	player.dashing == true
	enemy.dashing == true
	animation.play('dash')
	CommanderDash.emit()
	player = get_tree().get_first_node_in_group("Player")
	
	
	
func Physics_Update(delta: float):
	if start:
		enemy.velocity = direction.normalized() * move_speed
	enemy.velocity.y = 0
	print(enemy.dashing)
	if !enemy.dashing:
		var nowstate = get_parent().get_current_state()
		print(nowstate.State_Name)
		if nowstate.State_Name == 'death':
			return
		Transitioned.emit(self, 'idle') 


func _on_commander_boss_commander_death() -> void:
	print("follow death signal")
	Transitioned.emit(self, 'death') 
