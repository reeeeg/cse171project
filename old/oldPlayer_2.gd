extends CharacterBody2D

class_name Player

@onready var animation = $AnimationPlayer
@onready var sprite = $Sprite2D




@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
@export var attacking = false
var attackType = 0



func _physics_process(delta: float) -> void:
	
	if Input.is_action_pressed("left"):
		sprite.scale.x = abs(sprite.scale.x) * -1	
		
	if Input.is_action_pressed("right"):
		sprite.scale.x = abs(sprite.scale.x)
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if Input.is_action_just_pressed('active') and !attacking:
		attack()
	
	updateAnimation()
	move_and_slide()
	

func updateAnimation():
	
		
	if !attacking:
		animation.play("Idle")
		
	
	
func attack():
	
	attacking = true
	if Input.is_action_pressed("up") and Input.is_action_pressed("active"):
		animation.play("JAtk")
		attackType = 2
		#attackHit($JAtkArea.get_overlapping_areas())
	elif Input.is_action_pressed("active") and !is_on_floor() and Input.is_action_pressed("down"):
		animation.play("DAtk")
		attackType = 1
		#attackHit($DAtkArea.get_overlapping_areas())
		
	#elif Input.is_action_pressed("active") and Input.is_action_pressed("down"):
		#animation.play("TAtk")
	else:
		animation.play("NAtk")
		attackType = 0
		#attackHit($NAtkArea.get_overlapping_areas())
		
#func attackHit(overlapping_objects):
	#for area in overlapping_objects:
		#if area:
			#var parent = area.get_parent()	
			#parent.queue_free()

func NAtkArea(area: Area2D) -> void:
	if(attacking and attackType == 0):
		if area.get_parent().is_in_group("Enemies"):
			area.get_parent().queue_free() # Replace with function body.


func DAtkArea(area: Area2D) -> void:
	if(attacking and attackType == 1):
		if area.get_parent().is_in_group("Enemies"):
			area.get_parent().queue_free() # Replace with function body.
			

func JAtkArea(area: Area2D) -> void:
	if(attacking and attackType == 2):
		if area.get_parent().is_in_group("Enemies"):
			area.get_parent().queue_free()  # Replace with function body.
