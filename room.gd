class_name Room extends MapElement

var coordinate:Vector2
var extensions:Array[RoomExt]
var resource:RoomResource

func cleanup():
	for element:MapElement in extensions + [self]:
		for link:MapElement in element.nesw:
			if link == null or link == self or link in extensions:
				continue
			
			link.nesw[link.nesw.find(element)] = null
			element.queue_free()
