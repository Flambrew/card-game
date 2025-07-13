# finished - just an example entitystate definition

class_name ChaseState extends State

@export var entity:Entity
@export var speed_multiplier:float

var target:Entity
var distance:float
var duration:float

func enter() -> void:
	target = get_tree().get_first_node_in_group("PlayerCharacter")
	random_duration()

func update(delta:float) -> void:
	entity.look_at(target.position)
	distance = (target.position - entity.position).length()
	
	if distance > 20:
		Transition.emit(self, "Idle")
		return
	if distance < 5:
		Transition.emit(self, "Stand")
		return
		
	if duration > 0:
		duration -= delta
	elif distance > 12.5 and randf() > .3:
		Transition.emit(self, "FireFollow")
		return
	else:
		random_duration()

func physics_update(delta:float) -> void:
	var direction = Vector3.FORWARD * entity.speed * speed_multiplier
	entity.body_velocity = Utils.set_vector_xz(entity.body_velocity, direction)

func random_duration() -> void:
	duration = randf_range(.1, 2)
