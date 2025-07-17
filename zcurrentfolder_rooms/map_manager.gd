extends Node3D

const ROOM_SCENES = "res://zcurrentfolder_rooms/rooms/"

signal ChangeRoom

var room_list:Array[PackedScene]

var memory:int = 3 # implement into player
var current:Room
var all_rooms:Array[Room]
var id:int = 0

var prev_door:Door = null

func _init() -> void:
	ChangeRoom.connect(change_room)
	
	var dir := DirAccess.open(ROOM_SCENES)
	if not dir: printerr("Room scenes path not accesible.")
	for file in dir.get_files():
		if file.get_extension() == "tscn":
			room_list.append(load(ROOM_SCENES + file))

func _ready() -> void:
	var room = new_random_room()
	get_tree().get_first_node_in_group("GameScene").add_child(room)
	room.add_to_group("Room")
	room.enter.call_deferred()
	
	all_rooms.append(room)
	current = room

func change_room(exit_door:Door) -> void:
	var room
	if not exit_door.connection:
		room = new_random_room()
		all_rooms.append(room)
		room.add_to_group("Room")
		exit_door.link(room.doors[randi_range(0, room.doors.size() - 1)])
	else:
		room = exit_door.connection.room
	
	var root = get_tree().get_first_node_in_group("GameScene")
	root.remove_child(get_tree().get_first_node_in_group("Room"))
	root.add_child(room)
	room.enter(exit_door.connection)
	
	current = room
	cull_map_tree()
	print("room_id: ", current.id, ", all_ids: ", all_rooms.map(func(x:Room): return x.id), "\n")

func new_random_room() -> Room:
	return room_list[randi_range(0, room_list.size() - 1)].instantiate()

func next_id() -> int:
	id += 1
	return id - 1

# TREE CULLING
func cull_map_tree() -> void:
	var tree_contents:Dictionary[int, Room] = _map_tree_to_depth()
	for room in all_rooms:
		if room not in tree_contents.values():
			all_rooms.erase(room)
			room.cleanup()

func _map_tree_to_depth(head:Room=current, depth:int=memory) -> Dictionary[int, Room]:
	if depth == 0: return {head.id: head}
	var out:Dictionary[int, Room]
	for door:Door in head.doors:
		if door.connection:
			for room in _map_tree_to_depth(door.connection.room, depth - 1).values():
				out.get_or_add(room.id, room)
	out.get_or_add(head.id, head)
	return out
