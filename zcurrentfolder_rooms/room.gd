class_name Room extends Node3D

@export var doors:Array[Door]

var id:int
var rgb:Color

func _ready() -> void: 
	id = MapManager.next_id()

func enter(entrance:Door=doors[0]):
	var player:Node3D = get_tree().get_first_node_in_group("PlayerCharacter")
	
	if entrance:
		player.position = entrance.exit_point.global_position
		print("place: ", entrance.exit_point.global_position, ",\t", player.position)
		var diff = entrance.global_position - player.global_position
		player.rotation.y = atan2(-diff.x, -diff.z) + PI

func cleanup() -> void:
	for door in doors:
		door.unlink()
	queue_free()
