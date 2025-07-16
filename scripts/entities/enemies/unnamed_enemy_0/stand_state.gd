# finished - just an example entitystate definition

class_name StandState extends State

@export var entity:Entity

var target:Entity
var direction:Vector3

func enter() -> void:
	target = get_tree().get_first_node_in_group("PlayerCharacter")

func update(delta:float) -> void:
	entity.look_at(target.position)
	entity.apply_drag(2)
	
	if (target.position - entity.position).length() > 5:
		Transition.emit(self, "Chase")
