extends CharacterBody2D
class_name Ship

@export var ship_display_name : String = "Big Chud" #Monster Destroyer, Fyre Frigate 
@export var ship_type: String = "Default"
@export var fuel_capacity: float = 100.0
@export var fuel_consumption_rate : float = 0.001
@export var current_fuel: float = 100.0
@export var max_speed: float = 200.0
@export var patrol_radius: float = 500.0



#@export var sprite_path: String = "res://sprites/ships/frigate.png"


var navigator : NavigationAgent2D
#var begin_new_nav : bool = false
var speed : float = 500
var route : Array[Port]

func _ready() -> void:
	shipSetup()

func shipSetup() -> void:
	navigator = get_node("NavigationAgent2D") #target_pos tells nav agent to calculate path to pos
	print(navigator)
	navigator.navigation_finished.connect(onNavComplete)

func _process(_delta: float) -> void:
	var pos : Vector2 = navigator.get_next_path_position()
	rotate(get_angle_to(pos))
	
	if !navigator.is_target_reached():
		velocity = transform.x*speed
		current_fuel -= fuel_consumption_rate
	else:
		velocity = Vector2.ZERO
	
	move_and_slide()

func showInfo():
	var ui : UiInfoShip = get_node("%ShipInfoUI")
	ui.showInfo(self)

func onNavComplete():
	pass
	#on a layover, call make ship on port where we stop then free yourself
	#queue_free()
