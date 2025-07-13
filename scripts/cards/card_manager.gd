# todo:
# 	modular way of applying a deck-state

extends Node3D

signal Prev
signal Next
signal Play
signal Discard
signal Ready

@export var entity:Entity

var selected:int=0
var deck:Array[Card] = []
var hand:Array[Card] = []
var discard_pile:Array[Card] = []
var garbage_pile:Array[Card] = []

func _ready() -> void:
	_initialize()
	_draw(true)
	Prev.connect(select_prev)
	Next.connect(select_next)
	Play.connect(play_card)
	Discard.connect(discard)
	Ready.connect(_initialize)

func _process(delta:float) -> void:
	if deck.size() == 0:
		_shuffle(true)

func select_prev() -> void:
	if hand.size() == 0:
		selected = -1
	else:
		selected = clampi(selected - 1, 0, hand.size() - 1)

func select_next() -> void:
	if hand.size() == 0:
		selected = -1
	else:
		selected = clampi(selected + 1, 0, hand.size() - 1)

func play_card() -> void:
	if selected == -1: return
	
	hand[selected].Action.emit(entity)
	if hand[selected].single_use:
		_burn()
	else:
		_discard()

func discard() -> void:
	if selected == -1: return
	
	if hand[selected].single_opportunity:
		_burn()
	else:
		_discard()

# --- manipulations --- #

func _initialize() -> void:
	for child in get_children():
		if child is Card:
			deck.append(child)
	_shuffle()
	hand = []
	discard_pile = []
	garbage_pile = []

func _shuffle(refill:bool=true) -> void:
	if refill:
		for i in discard_pile.size():
			deck.append(discard_pile.pop_back())
			
	for i in deck.size():
		deck.insert(i, deck.pop_at(randi_range(i, deck.size() - 1)))

func _draw(fill:bool=false) -> void:
	_shuffle()
	if deck.size() == 0: return
	
	hand.append(deck.pop_back())
	if fill and hand.size() < entity.hand_limit:
		_draw(true)

func _discard(maintain_order:bool=true) -> void:
	if selected == -1: return
	
	discard_pile.append(hand.pop_at(selected))
	if maintain_order:
		hand.insert(selected, deck.pop_back())
	else:
		hand.append(deck.pop_back())

func _burn(maintain_order:bool=true) -> void:
	if selected == -1: return
	
	garbage_pile.append(hand.pop_at(selected))
	if maintain_order:
		hand.insert(selected, deck.pop_back())
	else:
		hand.append(deck.pop_back())
