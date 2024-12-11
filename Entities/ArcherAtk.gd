extends State

@export var enemy: CharacterBody2D

var player : CharacterBody2D

@onready var animation = $"../../AnimationPlayer"
@onready var sprite = $"../../CollisionShape2D"

func Enter():
	print("entered atk")
	player = get_tree().get_first_node_in_group("Player")
	var direction = player.global_position - enemy.global_position
	direction = player.global_position - enemy.global_position
	
	if direction.x < 0.0:
		enemy.velocity.x = 0.1
		enemy.facingforward = true
		sprite.scale.x = abs(sprite.scale.x) * -1
	else:
		enemy.velocity.x = -.01
		enemy.facingforward = false
		sprite.scale.x = abs(sprite.scale.x)
	enemy.velocity.x = 0
	animation.stop(true)
	animation.clear_queue()
	animation.play('atk')



func _on_archer_boss_archer_mele() -> void:
	var nowstate = get_parent().get_current_state()
	print(nowstate.State_Name)
	if nowstate.State_Name == 'death':
		return
	#if nowstate.State_Name == 'atk':
	Transitioned.emit(self, 'idle')
	


func _on_archer_boss_archer_death() -> void:
	print("idle death signal")
	Transitioned.emit(self, 'death')
