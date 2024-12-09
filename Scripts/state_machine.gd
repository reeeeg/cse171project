extends Node

@export var initial_state : State

@export var current_state : State :get = get_current_state
@export var current_state_name : String
var states : Dictionary = {}

var tempname : String
func _ready():
	for child in get_children():
		if child is State:
			tempname = child.name.to_lower()
			states[tempname] = child
			states[tempname].State_Name = tempname
			child.Transitioned.connect(on_child_transition)
			
	if initial_state:
		initial_state.Enter()
		current_state = initial_state
		
		
		
	
func _process(delta):
	if current_state:
		current_state.Update(delta)
		
func _physics_process(delta):
	if current_state:
		current_state.Physics_Update(delta)
		
func on_child_transition(state, new_state_name):
	if state != current_state:
		return
	
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
		
	if current_state:
		current_state.Exit()
	
	new_state.Enter()
	current_state = new_state
func get_current_state():
	return current_state
