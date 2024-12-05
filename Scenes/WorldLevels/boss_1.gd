extends CharacterBody2D

var speed = 20.0

var facing_right = true

const SPEED = 300.0
const JUMP_VELOCITY = -400.0


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

func flip():
	facing_right = !facing_right
	
	#scale.x = abs(scale.x) * -1
	
	if facing_right:
		speed = abs(speed)
	else:
		speed = abs(speed) * -1



func _on_health_health_depleted() -> void:
	queue_free()
