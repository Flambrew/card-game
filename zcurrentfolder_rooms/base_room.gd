class_name BaseRoom extends StaticBody3D

var id:int
var coords:Array[Vector2]
var doors:Array

var neighbors:Array[BaseRoom]

func _init() -> void:
	self.id = MapManager._next_id()

func _ready() -> void: 
	var color:Color = Color(randf()/2+.25, randf()/2+.25, randf()/2+.25)
	#for plane in $Bounds/Mesh.get_children():
		#((plane as MeshInstance3D).get_active_material(0) as BaseMaterial3D).albedo_color = color

func cleanup() -> void:
	for room in neighbors:
		room.neighbors.erase(self)
	queue_free()
