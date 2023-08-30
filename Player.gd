extends Node2D


@export var mov := Vector2(1,1)
@export var acceleration := 2.0
@export var speed := 0.0
@export var walk_speed := 10.0
@export var run_speed := 10.0
@export var max_hp:int=100
@export var hp:int=100




@onready var sprite = $Sprite2D
@onready var body = $CharacterBody2D
@onready var shape = $CharacterBody2D/CollisionShape2D
@onready var camera = $Camera2D

func _ready():
	pass # Replace with function body.


func _process(_delta):
	walk()


func walk():
	var x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	var y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	position += Vector2(x,y).normalized() * speed
