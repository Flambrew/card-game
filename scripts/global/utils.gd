# this class should NEVER be left unfinished.

extends Node

var debug_toggle:bool = true

const base_projectile:PackedScene = preload("res://scenes/unsorted/base_projectile.tscn")
func summon_projectile(parent:Entity, specification:ProjectileResource) -> void:
	var instance:BaseProjectile = base_projectile.instantiate() as BaseProjectile
	var emitter:Node3D = parent.find_child("ProjectileEmitter")
	var sight_raycast:RayCast3D = parent.find_child("SightRaycast") as RayCast3D
	
	var cast_point:Vector3 = sight_raycast.global_position + sight_raycast.to_global(sight_raycast.target_position)
	if sight_raycast.is_colliding():
		cast_point = sight_raycast.get_collision_point()
	
	instance.direction = (cast_point - emitter.global_position).normalized()
	instance.origin = emitter.global_position 
	instance.creator = parent
	
	instance.spec.speed = specification.speed
	instance.spec.damage_on_hit = specification.damage_on_hit
	if not specification.mesh_path.is_empty():
		(instance.find_child("Mesh") as MeshInstance3D).mesh = load(specification.mesh_path)
	
	instance.position = instance.origin
	ProjectileManager.add_child(instance)

func set_vector_xz(target:Vector3, source:Vector3) -> Vector3:
	target.x = source.x
	target.z = source.z
	return target

func card_lookup(id:int) -> Card:
	match id:
		0: return Dash.new()
	return null
