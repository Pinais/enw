extends Node2D


@export var mov : Vector2 = Vector2(1,1)
@export var acceleration : float = 0.5
@export var speed : float = 0.0
@export var walk_speed : float = 5.0
@export var run_extra_speed : float = 2.0
@export var max_stamina : int = 100
@export var stamina : int = max_stamina
@export var max_hp : int = 100
@export var hp : int = max_hp
@export var max_food : int = 1000
@export var food : int = max_food


var running : int = 0
var trying_to_run : bool = false


@onready var main_hand : Node2D = $EmptyHand
@onready var sprite = $Sprite2D
@onready var body = $CharacterBody2D
@onready var shape = $CharacterBody2D/CollisionShape2D
@onready var camera = $Camera2D
@onready var hpbar = $Camera2D/Control/ProgressBar
@onready var foodbar = $Camera2D/Control/ProgressBar2
@onready var staminabar = $Camera2D/Control/ProgressBar3


func _ready():
	main_hand.initialize(self)
	hpbar.max_value = max_hp
	staminabar.max_value = max_stamina
	foodbar.max_value = max_food
	hpbar.value = hp
	staminabar.value = stamina
	foodbar.value = food


func _process(_delta):
	move()
	manage_stamina()

func update_stamina(value:int):
	stamina = clamp(stamina + value, 0, max_stamina)
	staminabar.value = stamina

func update_hp(value:int):
	hpbar.value = hp

func update_food(value:int):
	food = clamp(food + value, 0, max_food)
	foodbar.value = food

func manage_stamina():
	if trying_to_run:
		if stamina > 0:
			running = 1
		else:
			running = 0
		update_stamina(-1)
	elif not trying_to_run:
		running = 0
		update_stamina(1)
		if stamina < max_stamina:
			update_food(-1)

func move():
	mov.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	mov.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	if not mov.is_zero_approx():
		if Input.is_action_pressed("run"):
			trying_to_run = true
		else:
			trying_to_run = false
		speed = clampf(speed + acceleration,0,walk_speed+running*run_extra_speed)
	else:
		speed = clampf(speed - 2*acceleration,0,walk_speed)
		trying_to_run = false
	position += mov.normalized() * speed


func _input(_event):
	if Input.is_action_pressed("primary_action"):
		main_hand.primary_action()
