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
const ROOM_SCENES = "res://zcurrentfolder_rooms/rooms/"

var memory:int = 3 # implement into player
var current:BaseRoom
var all_rooms:Array[BaseRoom]

func _ready() -> void:
	all_rooms.append(BaseRoomSingle.new(1, [Vector2(10, 10)]))
	all_rooms.append(BaseRoomSingle.new(2, [Vector2(11, 11)]))
	current = all_rooms[0]
	var can = candidates(Vector2(10, 11))
	print(can, "\n", can.size())

func place_room(room_descriptor:int, target:Vector2) -> void:
	var category:int = room_descriptor % 100
	var origin:int = room_descriptor % 10

func candidates(target:Vector2) -> Array[int]:
	var center:Vector2 = Vector2(DIM / 2, DIM / 2)
	var map:Array[int]
	map.resize(DIM ** 2)
	map.fill(NULL_ID)
	
	# create array of room ids
	for room:BaseRoom in all_rooms:
		for section:Vector2 in room.coords:
			var coord:Vector2 = section - current.coords[0] + center
			map[coord.y * DIM + coord.x] = room.id
	
	for i in DIM:
		print(map.slice(DIM*i, DIM*(i+1)))
	
	var out:Array[int]
	var target_point:Vector2 = target - current.coords[0] + center
	print(center, ", ", target_point)
	# each type of room
	for type in ROOM_TYPES: 
		# each translation of the room type
		for i in (shapes[type] as Array[Vector2]).size():
			# each rotation of that translation
			for j in 4: 
				print()
				
				var valid:bool = true
				# each point in that rotation
				for point in shape_rotate(shape_translate(shapes[type], i), j):
					var x:int = target_point.x + point.x
					var y:int = target_point.y + point.y
					
					
					# valid, in-bounds coordinate
					if x < 0 or x >= DIM or y < 0 or y >= DIM:
						valid = false
						print(type,"\ttr:",i,", rt:",j,", pt:",point,"||x:",x,",y:",y,"; fail 0")
						break
						
					# coordinate is full
					if map[y * DIM + x] != NULL_ID:
						valid = false
						print(type,"\ttr:",i,", rt:",j,", pt:",point,"||x:",x,",y:",y,"; fail 1")
						break
					print(type,"\ttr:",i,", rt:",j,", pt:",point,"||x:",x,",y:",y,"")
						
				if valid:
					print("shape success")
					out.append(type + i*10 + j)
				else: print("shape failure")
	return out

const shapes = {
	SINGLE: [Vector2(0, 0)],
	DOUBLE: [Vector2(0, 0), Vector2(0, 1)],
	TRIPLE: [Vector2(0, 0), Vector2(0, 1), Vector2(0, 2)],
	BEND: [Vector2(0, 0), Vector2(0, 1), Vector2(1, 1)],
	BOX: [Vector2(0, 0), Vector2(1, 0), Vector2(0, 1), Vector2(1, 1)],
	ARENA: [Vector2(-1, -1), Vector2(-1, 0), Vector2(-1, 1), Vector2(0, -1),
			Vector2(0, 0), Vector2(0, 1), Vector2(1, -1), Vector2(1, 0), Vector2(1, 1)]
}

func shape_translate(shape:Array, point:int) -> Array[Vector2]:
	var out:Array[Vector2] = []
	for coord in shape:
		out.append(coord - shape[point])
	return out

func shape_rotate(shape:Array, turns:int) -> Array[Vector2]:
	var out:Array[Vector2] = []
	for coord in shape:
		out.append(coord.rotated(PI/2 * turns))
	return out
