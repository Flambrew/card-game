class_name BaseRoom extends Node3D

var id:int
var coords:Array[Vector2]

func _init(id:int, coords:Array[Vector2]) -> void:
	self.id = id
	self.coords = coords

func _ready() -> void: 
	rand_color()

func rand_color() -> void:
	var color:Color = Color(randf()/2+.25, randf()/2+.25, randf()/2+.25)
	for plane in $Bounds/Mesh.get_children():
		((plane as MeshInstance3D).get_active_material(0) as BaseMaterial3D).albedo_color = color
