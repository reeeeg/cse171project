extends CharacterBody2D



@onready var immortality = false
@onready var sprite = $Sprite2D
@onready var enve = $EnvironmentCollision
@onready var hitbox = $HitBox
@onready var hurtbox = $HurtBox
@onready var animation = $AnimationPlayer
@onready var timer = $cooldown


var player : CharacterBody2D




#state ends
@export var begun = false
@export var attacked = false
@export var idleState = false
@export var followState = false
@export var meleState = false
@export var dashState = false
@export var alive = true


@export var move_speed := 10.0

var move_direction : Vector2

var roullette : int

func _ready() -> void:
	animation.play("Activate")
	
func states() -> bool:
	if idleState or followState or meleState or dashState or !alive or !begun:
		return true
	return false

func _physics_process(delta):
	if !begun or !alive or idleState:
		return
	move_and_slide()
	collision_updates()
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	idle(delta)
	#if !states:	
		#roullette = randi_range(1,3)
	#if roullette == 1:
		#idleState = true
		#idle(delta)
	#if roullette == 2:
		#followState = true
		#follow()
	#if roullette == 3:
		#dashState = true
		#dash()
	
		
	
	

func collision_updates():
	if velocity.length() > 0:
		$AnimationPlayer.play('walk')
		print("walk animation started")
	
	
	if velocity.x > 0:
		sprite.flip_h = false
		enve.scale.x = abs(enve.scale.x)
		hitbox.scale.x = abs(hitbox.scale.x)
		hurtbox.scale.x = abs(hurtbox.scale.x)
		
	else:
		if velocity.x < 0:
			sprite.flip_h = true
			enve.scale.x = abs(enve.scale.x) * -1
			hitbox.scale.x = abs(hitbox.scale.x) * -1
			hurtbox.scale.x = abs(hurtbox.scale.x) * -1

func idle(delta):
	var counter = randi_range(-1,1)
	
	self.velocity.x = abs(move_speed) * counter
	await get_tree().create_timer(20.0).timeout
	idleState = false
		
		
func follow():
	player = get_tree().get_first_node_in_group("Player")
	var direction = player.global_position - self.global_position
	
	if direction.length() > 200:
		self.velocity = direction.normalized() * move_speed
		
	else:
		followState = false
		meleState = true
		mele()
	
	
	

func mele():
	animation.play('atk2')
	await(2.0)
	meleState = false
	
func dash():
	dashState = false

func _on_health_health_depleted() -> void:
	alive = false
	animation.play('death')
	print("death signal emitted")
	#death.emit()
