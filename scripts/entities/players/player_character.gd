# todo: 
# 	card selection framework
# 	card display.. uielement stuff

class_name PlayerCharacter extends Entity

@onready var camera_pivot:Node3D = %CameraPivot

@export_range(0.0,1.0) var mouse_sensitivity:float = 50
const SENSITIVITY_MODIFIER:float = 125E-6

func _init() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event:InputEvent) -> void:
	if event is InputEventMouseMotion:
		camera_pivot.rotation.x -= event.relative.y * mouse_sensitivity * SENSITIVITY_MODIFIER
		camera_pivot.rotation.x = clampf(camera_pivot.rotation.x, -5 * PI / 12, PI / 4)
		rotation.y += -event.relative.x * mouse_sensitivity * SENSITIVITY_MODIFIER

func _physics_process(delta:float) -> void:
	super(delta)
	movement(delta)

func _process(_delta:float) -> void:
	if Input.is_action_just_pressed("action"):
		Utils.summon_projectile(self, load("res://resources/projectiles/basic_projectile.tres"))

func movement(delta:float) -> void:
	var direction:Vector3 = Vector3.ZERO
	
	if Input.is_action_pressed("move_forward"): direction += Vector3.FORWARD
	if Input.is_action_pressed("move_back"): direction += Vector3.BACK
	if Input.is_action_pressed("move_left"): direction += Vector3.LEFT
	if Input.is_action_pressed("move_right"): direction += Vector3.RIGHT
	if Input.is_action_just_pressed("jump") and is_on_floor():
		impulse(Vector3.UP, 8)
	
	body_velocity = Utils.set_vector_xz(body_velocity, direction.normalized() * speed)
