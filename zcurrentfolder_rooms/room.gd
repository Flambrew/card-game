class_name Room extends StaticBody3D

@onready var debug_mesh_parent:Node3D = %DebugMeshParent

@export var doors:Array[Door]

var id:int
var rgb:Color

func _ready() -> void: 
	id = MapManager.next_id()
	if Utils.debug_toggle and debug_mesh_parent:
		debug_mesh_parent.show()
		rgb = Color(randf()/2+.25, randf()/2+.25, randf()/2+.25)

func enter(entrance:Door=doors[0]):
	var player:Node3D = get_tree().get_first_node_in_group("PlayerCharacter")
	player.position = entrance.exit_point.global_position
	
	var diff = entrance.global_position - player.global_position
	player.rotation.y = atan2(-diff.x, -diff.z) + PI
	
	for plane in debug_mesh_parent.get_children():
		((plane as MeshInstance3D).get_active_material(0) as BaseMaterial3D).albedo_color = rgb

func cleanup() -> void:
	for door in doors:
		door.unlink()
	queue_free()
