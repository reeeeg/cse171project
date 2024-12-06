extends CharacterBody2D


@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
@onready var attacking = false

@onready var sprite = $Sprite2D
@onready var animation = $AnimationPlayer

func _physics_process(delta: float) -> void:
	
	if Input.is_action_pressed("left"):
		sprite.scale.x = abs(sprite.scale.x) * -1
		
	if Input.is_action_pressed("right"):
		sprite.scale.x = abs(sprite.scale.x)
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	var direction := Input.get_axis("left", "right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if Input.is_action_just_pressed('active') and !attacking:
		attack()
		
	update_animation()
	move_and_slide()
	
	
func update_animation():
	if !attacking:
		if velocity.x != 0:
			animation.play("run")
		else:
			animation.play("idle")
		
		if velocity.y > 0:
			animation.play("jump")
	

func attack():
	attacking == true
	animation.play("atk1")

func _on_health_health_depleted() -> void:
	queue_free()
