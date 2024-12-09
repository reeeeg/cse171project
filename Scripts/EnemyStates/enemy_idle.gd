extends State
class_name EnemyIdle

@export var enemy: CharacterBody2D
@export var move_speed := 10.0

@onready var animation = $"../../AnimationPlayer"


var move_direction : Vector2
var wander_time : float

func randomize_wander():
	move_direction = Vector2(randf_range(-1, 1), randf_range(-1,1)).normalized()
	wander_time = randf_range(1, 4)

func Enter():
	print("entered idle")
	randomize_wander()
	
func Update(delta: float):
	if wander_time == 4:
		Transitioned.emit(self, "follow")
	if wander_time > 0:
		wander_time -= delta
	else:
		Transitioned.emit(self, "follow")
		#randomize_wander()
		


func Physics_Update(delta: float):
	if enemy:
		enemy.velocity = move_direction * move_speed
		enemy.velocity.y = 5 * delta
		if not enemy.is_on_floor():
			enemy.velocity.y += 4 * delta


func _on_boss_1_death() -> void:
	print("idle death signal")
	Transitioned.emit(self, 'death') # Replace with function body.
