extends CharacterBody2D

@onready var immortality = false
@onready var sprite = $Sprite2D
@onready var env = $CollisionShape2D
@onready var hitbox = $HitBox
@onready var hurtbox = $HurtBox
@onready var animation = $CommanderAnimation
@export var MeleAttacked = false
@export var theFinalEnd = false


signal commander_death
signal commander_mele

@export var dashing = false

var dead = false

func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_signal)

func _physics_process(delta: float) -> void:
	if theFinalEnd:
		theFinalEnd = false
		Victory()
	if dead:
		return
		
	if not is_on_floor():
		velocity += get_gravity() * delta

	move_and_slide()
	if velocity.x > 0:
		sprite.flip_h = false
		env.scale.x = abs(env.scale.x)
		hitbox.scale.x = abs(hitbox.scale.x)
		hurtbox.scale.x = abs(hurtbox.scale.x)
		
	else:
		if velocity.x < 0:
			sprite.flip_h = true
			env.scale.x = abs(env.scale.x) * -1
			hitbox.scale.x = abs(hitbox.scale.x) * -1
			hurtbox.scale.x = abs(hurtbox.scale.x) * -1
	
	if velocity.length() > 0 and !dashing:
		animation.play('idle')
		
	if MeleAttacked == true:
		print("attackfinished")
		MeleAttacked = false
		commander_mele.emit()
		
func _on_dialogic_signal(argument:String):
	if argument == "gameEndingScreen":
		get_tree().change_scene_to_file("res://Scenes/GameEnding/gameEnding.tscn")
		#queue_free()
	pass

func _on_health_health_depleted() -> void:
	dead = true
	animation.play('death')
	print("death signal emitted")
	commander_death.emit()


func Victory():
	Dialogic.start("res://storyTimelines/8_ending.dtl")
	#get_tree().change_scene_to_file("res://Scenes/GameEnding/gameEnding.tscn")
