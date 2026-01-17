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
var speed: float = 500
var current_target_port: Port = null
# var is_traveling: bool = false


#var begin_new_nav : bool = false
var route : Array[Port]

func _ready() -> void:
	shipSetup()

func shipSetup() -> void:
	navigator = get_node("NavigationAgent2D") #target_pos tells nav agent to calculate path to pos
	# print(navigator)
	navigator.navigation_finished.connect(onNavComplete) #when onNavComplete, navigation is finished


func _process(delta: float) -> void:
	var pos : Vector2 = navigator.get_next_path_position() # sets position as required by navigation object path. it works. it must be called every frame.
	rotate(get_angle_to(pos)) #what
	
	if !navigator.is_target_reached(): 
		velocity = transform.x*speed
		current_fuel -= fuel_consumption_rate #each frame, drain fuel from the ship
	else:
		velocity = Vector2.ZERO #if target reached, STOP

	move_and_slide() #moving the ship body? does it work? keena doesn't know.

	 #if current_fuel <= 0:
		#print("Out of fuel!")
		#velocity = Vector2.ZERO

func showInfo():
	var ui : UiInfoShip = get_node("%ShipInfoUI")
	ui.showInfo(self)

func onNavComplete():
	velocity = Vector2.ZERO
	if current_target_port:
		current_target_port.request_docking(self)
	else:
		pass
		#calculate next port
		
		
	#on a layover, call make ship on port where we stop then free yourself
	#queue_free()
