# finished - just an example entitystate definition

class_name ChaseState extends State

@export var entity:EnemyCharacter

var target:Entity
var distance:float
var duration:float

func enter() -> void:
	target = get_tree().get_first_node_in_group("PlayerCharacter")
	random_duration()

func update(delta:float) -> void:
	entity.set_target(target.global_position)
	
	if duration > 0:
		duration -= delta
	else:
		random_duration()

func physics_update(delta:float) -> void:
	entity.navigate(delta)

func random_duration() -> void:
	duration = randf_range(.1, 2)
