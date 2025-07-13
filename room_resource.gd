class_name RoomResource extends Resource

@export var id:int
@export var name:String
@export var shape:RoomShape
@export var entrances:Array[bool]
@export var model_path:String

enum RoomShape {
	SINGLE = 4, 	# 1x1
	H_DOUBLE = 6, 	# 1x2
	V_DOUBLE = 6,
	H_TRIPLE = 8, 	# 1x3
	V_TRIPLE = 8,
	NE_CORNER = 8, 	# 2x2 L
	SE_CORNER = 8,
	SW_CORNER = 8,
	NW_CORNER = 8,
	H_RECT = 10, 	# 2x3
	v_RECT = 10, 
	BOX_2 = 8,		# 2x2
	BOX_3 = 12,		# 3x3
	DONUT = 16		# 3x3 w hole
}
