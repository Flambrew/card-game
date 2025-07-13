# todo:
# 	functional, future updates likely

class_name Card extends Node3D

signal Action

var id:int
var mana_cost:int
var title:String
var rarity:CardRarity
var type:CardType
var sprite:Resource
var single_use:bool
var single_opportunity:bool

enum CardRarity { COMMON, UNCOMMON, RARE, LEGENDARY }
enum CardType { UTILITY, MOVEMENT, BUFF, ATTACK }

func _ready() -> void:
	Action.connect(action)

func action(_from:Entity) -> void:
	pass
