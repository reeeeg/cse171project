extends CharacterBody2D

var pos:Vector2
var rot:float
var dir:float
@export var speed = 600

@onready var sprite := $Sprite2D
@export var sprit = sprite

func _ready():
	global_position = pos
	global_rotation = rot
func _physics_process(delta):
	velocity = Vector2(speed, 0).rotated(dir)
	if global_rotation < 0:
		sprite.scale.x = abs(sprite.scale.x) * -1
	else:
		sprite.scale.x = abs(sprite.scale.x)
	move_and_slide()
