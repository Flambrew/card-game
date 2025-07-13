# TODO: Savestate parsing of some sort

extends Node3D

var currency:Array[int]

enum CurrencyType {
	GOLD
}

func _ready() -> void:
	for i in CurrencyType.size():
		currency.append(0)

func amount_of(type:CurrencyType) -> int:
	return currency[type]

func subtract(type:CurrencyType, amount:int) -> void:
	currency[type] -= amount

func add(type:CurrencyType, amount:int) -> void:
	currency[type] += amount
