class_name Door extends Node3D

@onready var interaction_area:InteractionArea = %InteractionArea
@onready var debug_mesh:MeshInstance3D = %DebugMesh
@onready var exit_point:Node3D = %ExitPoint

@export var room:Room

var connection:Door

func _ready() -> void:
	if not Utils.debug_toggle:
		$DebugMesh.hide()

func _process(delta:float) -> void:
	if InteractionManager.key_pressed and interaction_area.is_active:
		MapManager.ChangeRoom.emit(self)

func link(target:Door) -> void:
	connection = target
	target.connection = self

func unlink() -> void:
	if connection:
		connection.connection = null
	connection = null
