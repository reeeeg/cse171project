extends CharacterBody2D

@onready var immortality = false
@onready var sprite = $Sprite2D
@onready var enve = $EnvironmentCollision
@onready var hitbox = $HitBox
@onready var hurtbox = $HurtBox
@export var attacked = false
@onready var animation = $AnimationPlayer
@export var theEnd1 = false

signal death
signal attackedfin

@export var dashing:= false

var dead = false

func _physics_process(delta):
	if theEnd1:
		nextLevel()
	if dead:
		return
	move_and_slide()
	
	if attacked == true:
		print("attackfinished")
		attacked = false
		attackedfin.emit()
	
	
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	
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
			
	
	if velocity.length() > 0 and !dashing:
		$AnimationPlayer.play('walk')
		print("walk animation started")



func _on_health_health_depleted() -> void:
	dead = true
	animation.play('death')
	print("death signal emitted")
	death.emit()


func _on_dash_dasher() -> void:
	print("dashing finished")
	dashing = true # Replace with function body.

func nextLevel():
	if get_tree().current_scene.name != "Level 0":
		get_tree().change_scene_to_file("res://Scenes/WorldLevels/SecondLevel.tscn")
