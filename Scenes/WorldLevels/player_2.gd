extends CharacterBody2D


@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
@export var attacking = false
@export var dashing = false
@export var deleted = false

@onready var arms = $arms
@onready var sprite = $Sprite2D
@onready var animation = $AnimationPlayer
@onready var env = $env
@onready var hurtbox = $HurtBox

#@onready var projectile = $Projectile
#@onready var main = get_tree().get_root().get_node("Player2")

var projectile = preload("res://Entities/Projectile.tscn")
var facingforward = true
var can_control : bool = true
var double_jump : bool = false

@export var shoot = false
var instance = projectile.instantiate()

func _ready() -> void:
	if !Globals.oscar:
		queue_free()
	Dialogic.signal_event.connect(_on_dialogic_signal)

func _on_dialogic_signal(argument:String):
	if argument == "introNoMovement":
		can_control = false
	if argument == "canPlay":
		can_control = true
		print("Player movement now enabled")
	if argument == "stopMovement":
		can_control = false

func _physics_process(delta: float) -> void:
	if deleted:
		game_over()
	if !can_control and PlayerStatus.alive:
		update_animation()
		can_control = false
	if !can_control or dashing:
		return
	
	if shoot:
		instance = projectile.instantiate()
		instance.speed = 600
		instance.pos = global_position
		instance.pos = self.global_position
		
		if !facingforward:
			instance.dir = rotation + PI
			instance.pos.x -= 80
		else:
			instance.dir = rotation
			instance.pos.x += 80
		
		
		instance.rot = rotation
		get_parent().add_child.call_deferred(instance)
		shoot = false
	if is_on_floor():
		double_jump = true
		
	if Input.is_action_pressed("Oleft"):
		sprite.scale.x = abs(sprite.scale.x) * -1
		arms.scale.x = abs(sprite.scale.x) * -1
		env.scale.x = abs(sprite.scale.x) * -1
		hurtbox.scale.x = abs(sprite.scale.x) * -1
		facingforward = false

		
	if Input.is_action_pressed("Oright"):
		sprite.scale.x = abs(sprite.scale.x)
		arms.scale.x = abs(sprite.scale.x)
		env.scale.x = abs(sprite.scale.x)
		hurtbox.scale.x = abs(sprite.scale.x)
		facingforward = true

	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Ojump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		double_jump = true
		
	if Input.is_action_just_pressed("Ojump") and !is_on_floor() and double_jump:
		velocity.y = JUMP_VELOCITY
		double_jump = false
	#if Input.is_action_just_pressed("dash"):
		#velocity.x = 0
		#velocity.y = 0
		#animation.play("dash")
		#if sprite.scale.x > 0:
			#velocity.x = 2000.0
		#else:
			#velocity.x = -2000.0
			

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("Oleft", "Oright")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if Input.is_action_just_pressed('Oactive'):
		attack()
	
	update_animation()
	move_and_slide()
	
	
func update_animation():
	if !attacking and !dashing:
		if velocity.x != 0:
			animation.play("run")
		else:
			animation.play("idle")
		
		#if velocity.y > 0:
			#animation.play("jump")
	

func attack():
	if attacking:
		return
	attacking = true
	animation.play("atk1")
	
	
func game_over():
	if get_tree().current_scene.name != "Level 0":
		get_tree().change_scene_to_file("res://Scenes/GameOver/gameOver.tscn")
	
func _on_health_health_depleted() -> void:
	PlayerStatus.alive = false
	can_control = false
	velocity.x = 0
	velocity.y = 0
	animation.play('death')
	if get_tree().current_scene.name != "Level 0":
		PlayerStatus.checkDead()
