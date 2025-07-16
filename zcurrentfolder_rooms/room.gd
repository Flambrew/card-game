class_name Room extends StaticBody3D

@onready var debug_mesh_parent:Node3D = %DebugMeshParent
@export var doors:Array[Door]

var id:int

func _ready() -> void: 
	id = MapManager.next_id()
	if Utils.debug_toggle and debug_mesh_parent:
		debug_mesh_parent.show()
		var rgb:Color = Color(randf()/2+.25, randf()/2+.25, randf()/2+.25)
		for plane in debug_mesh_parent.get_children():
			((plane as MeshInstance3D).get_active_material(0) as BaseMaterial3D).albedo_color = rgb

func enter(entrance:Door=doors[0]):
	var player:Node3D = get_tree().get_first_node_in_group("PlayerCharacter")
	player.position = entrance.exit_point.position
	player.look_at(entrance.position)
	player.rotation.y += PI

func cleanup() -> void:
	for door in doors:
		door.unlink()
	queue_free()
