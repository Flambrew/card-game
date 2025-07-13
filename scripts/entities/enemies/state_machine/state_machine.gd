# finished - there shouldnt be any more modifications needed by this class

class_name StateMachine extends Node

@export var initial_state:State

var current_state:State = null
var states:Dictionary[String, State] = {}

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name] = child
			child.Transition.connect(on_child_transition)
	if initial_state:
		current_state = initial_state
		initial_state.enter()
	print(current_state.name)

func _process(delta:float) -> void:
	if current_state:
		current_state.update(delta)

func _physics_process(delta:float) -> void:
	if current_state:
		current_state.physics_update(delta)

func on_child_transition(state:State, next_state_name:String) -> void:
	var next_state = states.get(next_state_name)
	if state != current_state: return
	if not next_state: return
	if current_state:
		current_state.exit()
	current_state = next_state
	next_state.enter()
	print(current_state.name)
