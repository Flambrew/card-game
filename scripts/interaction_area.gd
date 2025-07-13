class_name InteractionArea extends Area3D

@onready var player:Entity = get_tree().get_first_node_in_group("PlayerCharacter")
@onready var collider = %Collider

@export var radius:float = 3
@export var height:float = 2
@export var surface_planted:bool = true

var is_active:bool = false

func _ready() -> void:
	if Utils.debug_toggle:
		$DebugMesh.show()
		$DebugMesh.scale = Vector3(radius, height, radius)
	if surface_planted:
		collider.position.y = height / 2
	collider.scale = Vector3(radius, height, radius)

func _on_body_entered(body: Node3D) -> void:
	InteractionManager.add_area(self, body)

func _on_body_exited(body: Node3D) -> void:
	InteractionManager.rem_area(self, body)

func activate() -> void:
	is_active = true

func deactivate() -> void:
	is_active = false
