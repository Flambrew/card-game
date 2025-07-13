# finished - just an example entitystate definition

class_name IdleState extends State

@export var entity:Entity
@export var speed_multiplier:float

var target:Entity
var duration:float

func enter() -> void:
	target = get_tree().get_first_node_in_group("PlayerCharacter")
	choose_random_direction()

func update(delta:float) -> void:
	entity.look_at(target.position)
	if duration > 0:
		duration -= delta
	else:
		choose_random_direction()
	
	if (target.position - entity.position).length() < 20:
		Transition.emit(self, "FireFollow")
		return

func physics_update(delta:float) -> void:
	var direction = Vector3.FORWARD * entity.speed * speed_multiplier
	entity.body_velocity = Utils.set_vector_xz(entity.body_velocity, direction)

func choose_random_direction() -> void:
	entity.look_at(entity.position + Vector3.FORWARD.rotated(Vector3.UP, randf_range(0, 2 * PI)))
	duration = randf_range(1, 5)
