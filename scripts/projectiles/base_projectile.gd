# todo:
# 	performance of on-death effects

class_name BaseProjectile extends CharacterBody3D

var creator:Entity
var direction:Vector3
var origin:Vector3

var spec:ProjectileResource

func _init() -> void:
	spec = ProjectileResource.new()

func _ready() -> void:
	velocity = direction.normalized() * spec.speed

func _process(delta:float):
	look_at(position + direction)

func _physics_process(delta: float) -> void:
	var collision:KinematicCollision3D = move_and_collide(velocity * delta)
	if collision and not collision.get_collider() == creator:
		if collision.get_collider() is Entity:
			(collision.get_collider() as Entity).projectile_inflict(spec)
		kill()
	elif (position - origin).length() > 25:
		kill()

func kill() -> void:
	queue_free()
