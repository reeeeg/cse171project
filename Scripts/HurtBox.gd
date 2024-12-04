class_name HurtBox
extends Area2D

func _init() -> void:
	collision_layer = 2
	collision_mask = 0
	
func _ready() -> void:
	connect("area_entered", self, "on_area_entered")


func on_area_entered(hitbox: HitBox) -> void:
	if hitbox == null:
		return
		
	if owner.take_damage("take_damage"):
		owner.take_damage(hitbox_damage)
