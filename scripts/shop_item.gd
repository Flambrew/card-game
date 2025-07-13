class_name ShopItem extends Node3D

@onready var selection_area:Area3D = %SelectionArea
@onready var outline:MeshInstance3D = %Outline
@onready var label:Label3D = %Label

@export var currency:Array[CurrencyManager.CurrencyType]
@export var cost:Array[int]
@export var stock:int=1
