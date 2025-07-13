class_name PurchasePoint extends StaticBody3D

const ITEM_SPEED:float = 10
const ITEM_MAX_ROT:float = PI / 4
const INTERACTION_COOLDOWN:float = .5

@onready var interaction_area:InteractionArea = %InteractionArea
@onready var stock:Node3D = %Stock
@onready var player:Entity = get_tree().get_first_node_in_group("PlayerCharacter")

var cooldown:float

func _process(delta:float) -> void: 
	cooldown -= delta
	
	var child_count:int = stock.get_child_count()
	var index:int = get_targeted()
	
	for i in child_count:
		var child:ShopItem = stock.get_child(i)
		if not child: break
		child.position.x += ((i - (child_count-1) / 2.)*.9 - child.position.x) * ITEM_SPEED * delta
		
		var diff = (player.global_position - child.global_position)
		diff = diff.rotated(Vector3.UP, -global_rotation.y)
		var target_rot = clamp(atan2(-diff.x, -diff.z), -ITEM_MAX_ROT, ITEM_MAX_ROT)
		child.rotation.y += (target_rot - child.rotation.y) * ITEM_SPEED * delta
		
		if interaction_area.is_active and i == index:
			child.outline.show()
		else:
			child.outline.hide()
		
		if child.stock > 1:
			child.label.text = "(" + str(child.stock) + ")"
		else:
			child.label.text = ""
	
	if InteractionManager.key_pressed and cooldown<=0 and interaction_area.is_active and index!=-1:
		var child:ShopItem = stock.get_child(index)
		var item:ShopItem = purchase(index)
		print(index, ", ", item)
		if item:
			cooldown = INTERACTION_COOLDOWN
			if item.stock <= 0:
				stock.remove_child(child)
				child.queue_free()
			
			# DO STUFF TO GIVE THE PLAYER THE ITEM

func get_targeted() -> int:
	var collider = player.sight_raycast.find_child("AreaSightRaycast").get_collider() 
	if not collider: return -1
	for i in range(stock.get_child_count()).filter(func(i): return stock.get_child(i) is ShopItem):
		if collider == (stock.get_child(i) as ShopItem).selection_area:
			return i
	return -1

func purchase(index:int) -> ShopItem:
	if index >= stock.get_child_count() or index < 0: return null
	var item:ShopItem = stock.get_child(index)
	if item.stock <= 0: return null
	for i in item.currency.size():
		if CurrencyManager.amount_of(item.currency[i]) < item.cost[i]:
			return null
	for i in item.currency.size():
		CurrencyManager.subtract(item.currency[i], item.cost[i])
	item.stock -= 1
	return item
