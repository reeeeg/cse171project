extends State
class_name ArcherIdle

@onready var animation = $"../../AnimationPlayer"

@export var enemy: CharacterBody2D
@export var move_speed := 10.0

var player : CharacterBody2D

var move_direction : Vector2
var wander_time : float
var randomer : int

func randomize_wander():
	move_direction = Vector2(randf_range(-1, 1), randf_range(-1,1)).normalized()
	wander_time = randf_range(0.5, 1.5)
	randomer = randi_range(0,1)

func Enter():
	print("entered idle")
	animation.clear_queue()
	animation.play('idle')
	player = get_tree().get_first_node_in_group("Player")
	move_speed = 30
	randomize_wander()

func Update(delta: float):
	
	var nowstate = get_parent().get_current_state()
	if nowstate.State_Name != 'idle':
		return
	print(nowstate.State_Name)
	if nowstate.State_Name == 'death':
		return
	if randomer == 1:
		Transitioned.emit(self, 'atk')
	else:
		pass
		
	
	if wander_time > 0:
		wander_time -= delta
	else:
		randomize_wander()
		
func Physics_Update(delta: float):
	if enemy:
		enemy.velocity = move_direction * move_speed
		enemy.velocity.y = 0
		if !enemy.is_on_floor():
			enemy.velocity.y = 5*delta


func _on_archer_boss_archer_death() -> void:
	print("idle death signal")
	Transitioned.emit(self, 'death')
