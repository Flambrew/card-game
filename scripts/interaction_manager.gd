extends Node3D

@onready var player:Entity = get_tree().get_first_node_in_group("PlayerCharacter")

var active_areas:Array[InteractionArea] = []
var current_nearest_area:InteractionArea = null
var key_pressed:bool = false

func add_area(area:InteractionArea, body:Node3D) -> void:
	if body == player:
		active_areas.append(area)

func rem_area(area:InteractionArea, body:Node3D) -> void:
	var idx:int = active_areas.find(area)
	if body == player and idx != -1:
		active_areas.remove_at(idx)

func _process(delta:float) -> void:
	var nearest_area:InteractionArea = null
	var nearest_dist:float = 1000
	for area in active_areas:
		var dist:float = (player.global_position - area.global_position).length()
		if dist < nearest_dist:
			nearest_dist = dist
			nearest_area = area
	
	if current_nearest_area:
		if active_areas.size() == 0:
			current_nearest_area.deactivate()
			current_nearest_area = null
		elif current_nearest_area != nearest_area:
			current_nearest_area.deactivate()
			current_nearest_area = nearest_area
			current_nearest_area.activate()
	elif active_areas.size() != 0:
		current_nearest_area = nearest_area
		current_nearest_area.activate()
	
	key_pressed = Input.is_action_just_pressed("interact")
