extends CharacterBody2D

@onready var immortality = false
@onready var sprite = $Sprite2D
@onready var env = $CollisionShape2D
@onready var hurtbox = $HurtBox
@onready var animation = $AnimationPlayer
@export var shooting = false
@export var shotted = false

signal archer_death
signal archer_mele
@export var facingforward = true
var projectile = preload("res://Entities/Projectile.tscn")
@export var dashing = false
var instance
var dead = false

@export var theEnd = false

func _ready() -> void:
	#Dialogic.signal_event.connect(_on_dialogic_signal)

func _physics_process(delta: float) -> void:
	if theEnd:
		theEnd = false
		nextLevel()
	if dead:
		return
		
	if not is_on_floor():
		velocity += get_gravity() * delta

	move_and_slide()
	if velocity.x > 0:
		sprite.flip_h = false
		env.scale.x = abs(env.scale.x)
		hurtbox.scale.x = abs(hurtbox.scale.x)
		
	else:
		if velocity.x < 0:
			sprite.flip_h = true
			env.scale.x = abs(env.scale.x) * -1
			hurtbox.scale.x = abs(hurtbox.scale.x) * -1
			
	
	#if velocity.length() > 0 and !dashing:
		#animation.play('idle')
		#print("played idle animation from if statement")
	print(shotted)
	if shotted:
		var randomize = randi_range(5,11)
		instance = projectile.instantiate()
		instance.speed = 1000
		instance.pos = global_position
		instance.pos.y += randomize * 10
		if facingforward:
			instance.dir = rotation + PI
			instance.pos.x -= 120
		else:
			instance.dir = rotation
			instance.pos.x += 120
		
		
		instance.rot = rotation
		get_parent().add_child.call_deferred(instance)
		shotted = false
	
		print("attackfinished")
		
		archer_mele.emit()

#func _on_dialogic_signal(argument:String):
	#if argument == "afterFirstBoss":
		##Dialogic.start("res://storyTimelines/4_afterBoss1.dtl")
		#get_tree().change_scene_to_file("res://Scenes/WorldLevels/third_level.tscn")
		##queue_free()
	#pass

func _on_health_health_depleted() -> void:
	dead = true
	animation.play('death')
	print("death signal emitted")
	archer_death.emit()

func nextLevel():
	#Dialogic.start("res://storyTimelines/4_afterBoss1.dtl")
	#Dialogic.start("res://storyTimelines/4_afterBoss1.dtl")
	get_tree().change_scene_to_file("res://Scenes/WorldLevels/third_level.tscn")
	#Dialogic.start("res://storyTimelines/4_afterBoss1.dtl")
	pass
