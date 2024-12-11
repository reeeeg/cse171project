extends Node

@onready var alive = true
#var introSlimeAlive = true

# intro variables
var introSlimesDead = 0

@onready var meep = false
@onready var oscar = false
@onready var soup = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	#print(get_tree().current_scene.name)
	#if alive and get_tree().current_scene.name != "Level 0":
	##if alive:
		#print("checking alive")
		#checkDead()
	# if !alive and !introSlimeAlive:
	# 	print("dead")
	# 	get_tree().change_scene_to_file("res://Scenes/GameOver/gameOver.tscn")
	# 	alive = true
	pass

#func loadCharacters():
	#if PlayerStatus.meep:
		#load("res://Entities/player_1.tscn")
		#$Player1.position = Vector2(-959, 213)
		#$Player1.scale = Vector2(4, 4)
		#$Player1.visible = true
	#if PlayerStatus.oscar:
		#load("res://Entities/player_2.tscn")
		#$Player2.position = Vector2(-959, 200)
		#$Player2.scale = Vector2(4, 4)
		#$Player2.visible = true
	#if PlayerStatus.soup:
		#load("res://Entities/player_3.tscn")
		#$Player3.position = Vector2(-959, 185)
		#$Player3.scale = Vector2(4, 4)
		#$Player3.visible = true
	#
	#if !PlayerStatus.meep:
		#$Player1.queue_free()
	#if !PlayerStatus.oscar:
		#$Player2.queue_free()
	#if !PlayerStatus.soup:
		#$Player3.queue_free()

func checkDead():
	if !alive:
		print("dead")
		get_tree().change_scene_to_file("res://Scenes/GameOver/gameOver.tscn")
