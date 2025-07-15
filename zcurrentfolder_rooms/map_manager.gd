extends Node3D

const SINGLE = 0
const DOUBLE = 100
const TRIPLE = 200
const BEND = 300
const BOX = 400
const ARENA = 500

const ROOM_TYPES = [SINGLE, DOUBLE, TRIPLE, BEND, BOX, ARENA]

const DIM = 21
const NULL_ID = 0
const ROOM_SCENES = "res://zcurrentfolder_rooms/base_rooms/rooms/"

var memory:int = 3 # implement into player
var current:BaseRoom
var all_rooms:Array[BaseRoom]
var id_next:int = NULL_ID

func _ready() -> void:
	pass


# TREE CULLING
func cull_map_tree() -> void:
	var tree_contents:Array[BaseRoom] = _map_tree_to_depth()
	for room in all_rooms:
		if room not in tree_contents:
			all_rooms.erase(room)
			room.cleanup()

func _map_tree_to_depth(head:BaseRoom=current, depth:int=memory) -> Array[BaseRoom]:
	if depth == 0: return [head]
	var out:Array[BaseRoom]
	for room in head.neighbors:
		out.append_array(_map_tree_to_depth(room, depth - 1))
	return out

func _next_id() -> int:
	id_next += 1
	return id_next
