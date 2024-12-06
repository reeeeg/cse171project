class_name HitBox
extends Area2D

@export var damage: int = 1 : set = set_damage, get = get_damage 
@export var active = true

func set_damage(value: int):
	damage = value

func get_damage() -> int:
	return damage
