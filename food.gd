extends Node2D


@export var food_value : int = 20
@export var amount : int = 1
@export var max_amount : int = 10
var parent : Node2D = null


func initialize(_parent : Node2D):
	parent = _parent


func primary_action():
	if amount > 0:
		parent.update_food(food_value)
		amount = clamp(amount - 1, 0, max_amount)
