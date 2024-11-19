extends CharacterBody2D


var speed = 200.0

var attacking = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	#if !$RayCast2D.is_colliding() && is_on_floor():
		#flip()
		#
	#if !$RayCast2D2.is_colliding() && is_on_floor():
		#flip()
	
	
	velocity.x = speed

	move_and_slide()
