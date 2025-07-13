extends Node3D

# ADD TO AUTOLOAD GLOBAL LIST

var memory:int = 3 # link memory to player stats

var tree_head:Room
var room_list:Array[Room]

func _tree_to_depth(from:Room=tree_head, depth:int=1) -> Array[Room]:
	var neighbors:Array[Room] = from.neighbors.map(func(e): e if e is Room else e.room)
	
	if depth == memory:
		return neighbors
	
	var list:Array[Room]
	for room:Room in neighbors:
		list.append_array(_tree_to_depth(room, depth + 1))
	return list

func _cull_tree():
	var range:Array[Room] = _tree_to_depth()
	for room:Room in room_list:
		if room not in range:
			room_list.erase(room)
			room.cleanup()

func create_at(y_pos:int, x_pos:int, details:RoomResource):
	var room:Room = Room.new()
	
	# initialize
	# connect to neighbors
	
	room_list.append(Room)

func enter_door(door_id:int):
	pass
	
	# set tree_head to new room
	# cull room_list
