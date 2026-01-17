extends CharacterBody2D
class_name Ship

@export var nav_point_debug : Node2D
@export var fuel_capacity: float = 100.0
@export var fuel_consumption_rate : float = 0.001
@export var current_fuel: float = 100.0

var navigator : NavigationAgent2D
#var begin_new_nav : bool = false
var speed : float = 500

func _ready() -> void:
	shipSetup()

func shipSetup() -> void:
	navigator = get_node("NavigationAgent2D") #target_pos tells nav agent to calculate path to pos
	print(navigator)
	navigator.navigation_finished.connect(onNavComplete) 
	navigator.target_position = nav_point_debug.global_position #set target position to 

func _process(_delta: float) -> void:
	var pos : Vector2 = navigator.get_next_path_position()
	rotate(get_angle_to(pos))
	
	if !navigator.is_target_reached():
		velocity = transform.x*speed
		current_fuel -= fuel_consumption_rate
	else:
		velocity = Vector2.ZERO
	
	move_and_slide()

func onNavComplete():
	pass
	#on a layover, call make ship on port where we stop then free yourself
	#queue_free()
