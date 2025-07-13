# todo:
# 	projectile on-hit procedures

class_name Entity extends CharacterBody3D

@onready var sight_raycast:RayCast3D = %SightRaycast

const DRAG_COEFFICIENT:float = 0.01
const BASE_GRAVITY:float = -10

@export var gravity_multiplier:float = 1
@export var speed:float = 1

@export var max_health:float = 1
@export var health_regen_rate:float = 1
@export var max_mana:float = 1
@export var mana_regen_rate:float = 1

@export var hand_limit:int = 1

var health:float
var mana:float

var body_velocity:Vector3 = Vector3.ZERO
var grounded:bool = false

func _ready() -> void:
	health = max_health
	mana = max_mana

func _process(delta:float) -> void:
	replenish(delta)

func _physics_process(delta:float) -> void:
	perform_movement(delta)

func replenish(delta:float) -> void:
	health = min(max_health, health + delta * health_regen_rate)
	mana = min(max_mana, mana + delta * mana_regen_rate)

func perform_movement(delta:float) -> void:
	apply_drag()
	
	if not is_on_floor():
		body_velocity.y += BASE_GRAVITY * gravity_multiplier * delta
		grounded = false
	elif not grounded:
		body_velocity.y = 0
		grounded = true
	
	velocity = body_velocity.rotated(Vector3.UP, rotation.y)
	move_and_slide()

func impulse(direction:Vector3, strength:float) -> void:
	body_velocity += direction.normalized() * strength

func blink(direction:Vector3, distance:float) -> void:
	direction = direction.normalized()
	var query = PhysicsRayQueryParameters3D.create(position, position + direction * distance)
	var result = get_world_3d().direct_space_state.intersect_ray(query)
	if result: position = result.position
	else: position += direction * distance

func apply_drag(intensity:float=1) -> void:
	body_velocity *= pow(1 - DRAG_COEFFICIENT, intensity)

func projectile_inflict(spec:ProjectileResource) -> void:
	health -= 1
	print("collision detected - functionality unimplemented")
	print("health of ", name, " reduced to ", health)
