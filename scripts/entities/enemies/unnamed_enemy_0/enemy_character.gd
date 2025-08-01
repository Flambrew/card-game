class_name EnemyCharacter extends Entity

@onready var nav_agent:NavigationAgent3D = $NavigationAgent3D
@onready var state_machine:StateMachine = $StateMachine

func _ready() -> void:
	nav_agent.path_desired_distance = 0.5
	nav_agent.target_desired_distance = 0.5
	
	setup()

func setup():
	await get_tree().physics_frame
	set_target(global_position)

func navigate(delta:float) -> void:
	if nav_agent.is_navigation_finished():
		return
	
	var current_agent_position:Vector3 = global_position
	var next_path_position:Vector3 = nav_agent.get_next_path_position()
	var new_speed:float = speed * state_machine.current_state.speed_multiplier
	var new_velo:Vector3 = current_agent_position.direction_to(next_path_position) * new_speed
	
	body_velocity = Utils.set_vector_xz(body_velocity, new_velo)

func set_target(target_global:Vector3) -> void:
	nav_agent.set_target_position(target_global)
	#look_at(target_global)
